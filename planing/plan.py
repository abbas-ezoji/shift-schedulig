import pandas as pd
import numpy as np
from ga_numpy import GeneticAlgorithm as ga
import numpy_indexed as npi
from sqlalchemy.exc import SQLAlchemyError
from sqlalchemy import create_engine


##############################
city =  'استانبول'
start_time = 480
end_time = 1260

alpha = 0.8
beta = 0.2
gama = 0.0
##############################

USER = 'planuser'
PASSWORD = '1qaz!QAZ'
HOST = 'localhost'
PORT = '5432'
NAME = 'planing'
db_connection = "postgresql://{}:{}@{}:{}/{}".format(USER,
                                                         PASSWORD,
                                                         HOST,
                                                         PORT,
                                                         NAME
                                                        )
engine = create_engine(db_connection)
df = pd.read_sql_query('SELECT * FROM	plan_attractions',con=engine)
df = df.drop(['image'], axis=1)

df_city = df[df['city']==city]

dist_mat_query = ''' select 
                         origin_id as orgin
                        ,destination_id as dist
                        ,len_time as len
                     from 
                       plan_distance_mat
                     where
                       origin_id in 
                       (select id from plan_attractions
                        where city = 
                       '''
dist_mat_query = dist_mat_query + " '{0}' )".format(city)                    
dist_df = pd.read_sql_query(dist_mat_query
                          ,con=engine)

dist_mat = pd.pivot_table(dist_df,                           
                          index=['orgin'],
                          columns=['dist'], 
                          values='len', 
                          aggfunc=np.sum)

vst_time_from = df_city['vis_time_from'] 
vst_time_to = df_city['vis_time_to']
points = df_city['id']
rq_time = df_city['rq_time']

meta_data = np.array([points, rq_time], dtype=int)

pln_gene1 = np.array([points, 
                      rq_time, 
                      ], dtype=int).T
pln_gene2 = np.array([np.flip(points), 
                      np.flip(rq_time), 
                     ], dtype=int).T						  
							  
def lenght_cost(individual, meta_data):
    plan = individual
    len_pln = len(plan)
    edge = len_pln - 1   
    all_dist = 0
    all_duration = np.sum(plan[:,1])
    pln_pnt = plan[:,0]
    for i,orig in enumerate(pln_pnt):    
        if i<edge:
            all_dist += dist_mat.loc[orig , pln_pnt[i+1]]
    plan_lenght = all_dist + all_duration  
    cost = np.abs((start_time + plan_lenght) - end_time) / 1440.0    
      
    return cost
	
def count_cost(individual, meta_data):
    plan = individual
    len_pln = len(plan)
    len_points = len(meta_data[0])
    cost = np.abs(len_points-len_pln) / len_points
    
    return cost

def rqTime_cost(individual, meta_data):
    plan = individual
   
    t = np.concatenate((plan, meta_data.T))
    _, t_max = npi.group_by(t[:,0]).max(t)
    _, t_min = npi.group_by(t[:,0]).min(t)
    t = (t_max - t_min)/t_max
    diff = np.sum(t[:,1]) / len(plan)   
    
    return diff

def fitness(individual, meta_data):    
    _, individual = npi.group_by(individual[:,0]).max(individual)
    len_cost = lenght_cost(individual, meta_data)
    cnt_cost = count_cost(individual, meta_data)
    diff_rqTime_cost = rqTime_cost(individual, meta_data)
#    print(len_cost, cnt_cost, diff_rqTime_cost)
    cost = (alpha*len_cost) + (beta*cnt_cost) + (gama*diff_rqTime_cost)
#    print(cost)
    
    return cost

ga = ga(seed_data=pln_gene1,
        meta_data=meta_data,
        population_size=50,
        generations=500,
        crossover_probability=0.8,
        mutation_probability=0.2,
        elitism=True,
        by_parent=False,
        maximise_fitness=False)	
ga.fitness_function = fitness

ga.run()   

sol_fitness, sol_df = ga.best_individual()

plan = sol_df

len_pln = len(plan)
edge = len_pln - 1
all_dist = 0
all_duration = np.sum(plan[:,1])
pln_pnt = plan[:,0]
for i,orig in enumerate(pln_pnt):    
    if i<edge:
        all_dist += dist_mat.loc[orig , pln_pnt[i+1]]
plan_lenght = all_dist +all_duration  
t = (plan_lenght + start_time) - end_time