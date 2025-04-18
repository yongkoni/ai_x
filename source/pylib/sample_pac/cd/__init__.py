'''
sample_pac/cd/__init__.py
import sample_pac.cd.import *  수행할 경우 
자동 import 될 모듈 지정할 수 있음 (__all__)

sample_pac/cd/c.py
sample_pac/cd/d.py
'''

__all__ = ['c']
print('sample_pac패키지 안의 cd패키지 로드됩니다')