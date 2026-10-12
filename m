Received: from smtp.inf.ufrgs.br (smtp.inf.ufrgs.br [143.54.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6A336B920;
	Mon, 12 Oct 2026 05:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=143.54.11.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791783881; cv=none; b=IsjQ5pAcEQdS/KWjRg4nmQeejzyKQmP6Wrc+Lmo761629vj9ADT+dca5Wjw5C5bfGjXmx3PBA5m+tGaRMxM8M1zCr91lmaatYuLL/aU8cLYr4BSbIUdVi/Pd1cuhybpyqSTcefkl/jNHxSiF3tdDR0QHHSOhi0OHpiBxZAzlGxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791783881; c=relaxed/simple;
	bh=10zkugYWnlZeRqsBpwP6HRJdS096Q5/NnYDErOIt/X4=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=Ot0eAjw8K3Sk174Hvh+xsdBLm7KIp5wDaaGySrUE/JHdwD5RX8Zvfmo8uOfpgoCce7X533jAIIlmjCrC1HtEaUJ+y15NVc+SIHpJJd6jz4bHs5TwcU+AR9qScs/F8uw9c1k8mm/XaP5yLhNNYYyf7B/bl6Sq2xHKvzhVzbBo1BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inf.ufrgs.br; spf=pass smtp.mailfrom=inf.ufrgs.br; dkim=pass (2048-bit key) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.b=fUld1JFe; arc=none smtp.client-ip=143.54.11.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.b="fUld1JFe"
Received: from webmail.inf.ufrgs.br (webmail.inf.ufrgs.br [143.54.11.45])
	by smtp.inf.ufrgs.br (Postfix) with ESMTPSA id 0987E121113;
	Mon, 12 Oct 2026 02:44:36 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inf.ufrgs.br;
	s=dkim2026; t=1791783876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CbEGxOEFVQDKBurv9W0xsW1LVD9IOQc1CCYstynH8XU=;
	b=fUld1JFerj0PYC/m+cWTw+O9kczppw/2zjUM83MCD1yv1FS4qAdADsO6BfpUdWTyZnGn7W
	HEwhvhD7U9kZHfhbybTCEO0MiG/syfnKypGqLFqja7GCizdtBgTGv9xYDVxcnT2XUf+As4
	TjtfFXOMEmGjJ5Uv7/sYJyx/IokBMH6dx0IONujnBIFROOADpX8aPAUtCA4NRy/sqyp3IA
	3SW6GyJIBbe9QZYBXYnuU7IG3QY+7yk0Tj3dBf9ZOQt+9LN9fGQiVAvaLIUfLI0nSUtmMB
	UnYyqmQLJvFbQUiXxkMKn50wNCuLhTQEFbrZJOsYtrnKidhaX48tPmESXIwNtw==
Received: from bd06e904.virtua.com.br ([189.6.233.4])
 by webmail.inf.ufrgs.br
 with HTTP (HTTP/1.1 POST); Mon, 12 Oct 2026 02:44:35 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Mon, 12 Oct 2026 02:44:35 -0300
From: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] fat: return only first cluster when allocating
In-Reply-To: <87zewkkqtu.fsf@mail.parknet.co.jp>
References: <20261008020941.55784-1-matheus.aalmeida@inf.ufrgs.br>
 <20261008020941.55784-3-matheus.aalmeida@inf.ufrgs.br>
 <87zewkkqtu.fsf@mail.parknet.co.jp>
Message-ID: <3b610d3340eaa7c22bb1dd95b1ee9b95@inf.ufrgs.br>
X-Sender: matheus.aalmeida@inf.ufrgs.br
User-Agent: Roundcube Webmail/0.9.5

Em 2026-10-11 15:57, OGAWA Hirofumi escreveu:
> Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br> writes:
> 
>> fat_alloc_clusters() returns every allocated cluster number in an array.
>> For larger allocations, like growing a file, this array would need to be
>> very large.
>> 
>> Make fat_alloc_clusters() return only the first allocated cluster in the
>> chain. Update fat_add_new_entries() to follow the chain when it needs
>> the second cluster.
> 
> This would be more common case than fallocate(), so penalize this part
> would not be good.
> 
> Thanks.

That makes sense.

I can change the approach so that fat_alloc_clusters() and the directory
entry path are left unchanged. For fat_add_clusters(), I would add a
separate fat_alloc_chain() helper which allocates the whole chain but
only returns the first cluster.

Would that approach be preferable?

Thanks,
Matheus

>> Signed-off-by: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
>> ---
>>  fs/fat/dir.c    | 20 +++++++++++++++++++-
>>  fs/fat/fat.h    |  2 +-
>>  fs/fat/fatent.c | 17 +++++++++--------
>>  3 files changed, 29 insertions(+), 10 deletions(-)
>> 
>> diff --git a/fs/fat/dir.c b/fs/fat/dir.c
>> index 35bdb6294..672d5e392 100644
>> --- a/fs/fat/dir.c
>> +++ b/fs/fat/dir.c
>> @@ -1245,6 +1245,7 @@ static int fat_add_new_entries(struct inode *dir, 
>> void *slots, int nr_slots,
>>  	sector_t blknr, start_blknr, last_blknr;
>>  	unsigned long size, copy;
>>  	int err, i, n, offset, cluster[2];
>> +	struct fat_entry fatent;
>> 
>>  	/*
>>  	 * The minimum cluster size is 512bytes, and maximum entry
>> @@ -1255,10 +1256,26 @@ static int fat_add_new_entries(struct inode *dir, 
>> void *slots, int nr_slots,
>>  	*nr_cluster = (size + (sbi->cluster_size - 1)) >> sbi->cluster_bits;
>>  	BUG_ON(*nr_cluster > 2);
>> 
>> -	err = fat_alloc_clusters(dir, cluster, *nr_cluster);
>> +	err = fat_alloc_clusters(dir, &cluster[0], *nr_cluster);
>>  	if (err)
>>  		goto error;
>> 
>> +	if (*nr_cluster > 1) {
>> +		fatent_init(&fatent);
>> +		cluster[1] = fat_ent_read(dir, &fatent, cluster[0]);
>> +		fatent_brelse(&fatent);
>> +		if (cluster[1] == FAT_ENT_EOF || cluster[1] == FAT_ENT_FREE) {
>> +			fat_fs_error(sb,
>> +				     "%s: invalid cluster chain (i_pos %lld)",
>> +				     __func__, MSDOS_I(dir)->i_pos);
>> +			cluster[1] = -EIO;
>> +		}
>> +		if (cluster[1] < 0) {
>> +			err = cluster[1];
>> +			goto error_ent;
>> +		}
>> +	}
>> +
>>  	/*
>>  	 * First stage: Fill the directory entry.  NOTE: This cluster
>>  	 * is not referenced from any inode yet, so updates order is
>> @@ -1313,6 +1330,7 @@ static int fat_add_new_entries(struct inode *dir, 
>> void *slots, int nr_slots,
>>  error_nomem:
>>  	for (i = 0; i < n; i++)
>>  		bforget(bhs[i]);
>> +error_ent:
>>  	fat_free_clusters(dir, cluster[0]);
>>  error:
>>  	return err;
>> diff --git a/fs/fat/fat.h b/fs/fat/fat.h
>> index 61338413d..75ac0239a 100644
>> --- a/fs/fat/fat.h
>> +++ b/fs/fat/fat.h
>> @@ -393,7 +393,7 @@ extern int fat_ent_read(struct inode *inode, struct 
>> fat_entry *fatent,
>>  			int entry);
>>  extern int fat_ent_write(struct inode *inode, struct fat_entry *fatent,
>>  			 int new, int wait);
>> -extern int fat_alloc_clusters(struct inode *inode, int *cluster,
>> +extern int fat_alloc_clusters(struct inode *inode, int *first_cluster,
>>  			      int nr_cluster);
>>  extern int fat_free_clusters(struct inode *inode, int cluster);
>>  extern int fat_count_free_clusters(struct super_block *sb);
>> diff --git a/fs/fat/fatent.c b/fs/fat/fatent.c
>> index bfab8eab5..4970b1f14 100644
>> --- a/fs/fat/fatent.c
>> +++ b/fs/fat/fatent.c
>> @@ -488,14 +488,14 @@ static int fat_flush_bhs(struct super_block *sb, 
>> struct buffer_head **bhs,
>>  	return 0;
>>  }
>> 
>> -int fat_alloc_clusters(struct inode *inode, int *cluster, int nr_cluster)
>> +int fat_alloc_clusters(struct inode *inode, int *first_cluster, int 
>> nr_cluster)
>>  {
>>  	struct super_block *sb = inode->i_sb;
>>  	struct msdos_sb_info *sbi = MSDOS_SB(sb);
>>  	const struct fatent_operations *ops = sbi->fatent_ops;
>>  	struct fat_entry fatent, prev_ent;
>>  	struct buffer_head *bhs[MAX_BUF_PER_PAGE];
>> -	int i, count, err, nr_bhs, idx_clus;
>> +	int i, count, err, nr_bhs, clusters_done;
>> 
>>  	lock_fat(sbi);
>>  	if (sbi->free_clusters != -1 && sbi->free_clus_valid &&
>> @@ -504,7 +504,7 @@ int fat_alloc_clusters(struct inode *inode, int 
>> *cluster, int nr_cluster)
>>  		return -ENOSPC;
>>  	}
>> 
>> -	err = nr_bhs = idx_clus = 0;
>> +	err = nr_bhs = clusters_done = 0;
>>  	count = FAT_START_ENT;
>>  	fatent_init(&prev_ent);
>>  	fatent_init(&fatent);
>> @@ -531,8 +531,9 @@ int fat_alloc_clusters(struct inode *inode, int 
>> *cluster, int nr_cluster)
>>  				if (sbi->free_clusters != -1)
>>  					sbi->free_clusters--;
>> 
>> -				cluster[idx_clus] = entry;
>> -				idx_clus++;
>> +				if (!clusters_done)
>> +					*first_cluster = entry;
>> +				clusters_done++;
>> 
>>  				if (nr_bhs + fatent.nr_bhs > MAX_BUF_PER_PAGE) {
>>  					err = fat_flush_bhs(sb, bhs, &nr_bhs,
>> @@ -542,7 +543,7 @@ int fat_alloc_clusters(struct inode *inode, int 
>> *cluster, int nr_cluster)
>>  				}
>>  				fat_collect_bhs(bhs, &nr_bhs, &fatent);
>> 
>> -				if (idx_clus == nr_cluster)
>> +				if (clusters_done == nr_cluster)
>>  					goto out;
>> 
>>  				/*
>> @@ -575,8 +576,8 @@ int fat_alloc_clusters(struct inode *inode, int 
>> *cluster, int nr_cluster)
>>  	for (i = 0; i < nr_bhs; i++)
>>  		brelse(bhs[i]);
>> 
>> -	if (err && idx_clus)
>> -		fat_free_clusters(inode, cluster[0]);
>> +	if (err && clusters_done)
>> +		fat_free_clusters(inode, *first_cluster);
>> 
>>  	return err;
>>  }
