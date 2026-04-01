function pycache-cleanup --wraps=find\ .\ -regex\ \'^.\*\\\(__pycache__\\\|\\.py\[co\]\\\)\$\'\ -delete --description alias\ pycache-cleanup\ find\ .\ -regex\ \'^.\*\\\(__pycache__\\\|\\.py\[co\]\\\)\$\'\ -delete
  find . -regex '^.*\(__pycache__\|\.py[co]\)$' -delete $argv
        
end
