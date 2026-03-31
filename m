Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A33440DFB9;
	Tue, 31 Mar 2026 01:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774919578; cv=none; b=EJAsLI6hAWOWDizjeKkl+31ZAzqnxk/JNoJ/ohijDpV1T/7j0lvzsbL28MBtSmqI0dBxDTbzYcTvZOHRQmIt6WIjY6SA2qsWrv7bl2pMg0vpspL7FuCDnk3Q2yItmUdtpk7v1kCRmKILIV1oCT9qm+SiKvyQtStOg4Oq7/J+Bm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774919578; c=relaxed/simple;
	bh=DJ9zpY1zrrtP+U1kYVLB3A73OkHoMRic5tfw+VcR77c=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=b3uvArLbSRIfvV+t3xML1UGdvN26oNZbQmdVO/1ojENe9uSQS6GoC3eeRJtyc69rhTS3pHy05846hvfC/0LMNffVIPFe7dKv09qhqs661bLHbrwaKvi9GpDdpYb43rEjVcmvPmNKv+uUCPsX87U0ZX7nclsbDmhYObw8CZXO3dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 62V1C352058503;
	Tue, 31 Mar 2026 10:12:03 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.2] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 62V1C3YY058500
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 31 Mar 2026 10:12:03 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <5257abf7-6746-4719-9c5a-e1186883c608@I-love.SAKURA.ne.jp>
Date: Tue, 31 Mar 2026 10:12:02 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] hfs: update sanity check of the root record
To: Viacheslav Dubeyko <vdubeyko@redhat.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>
References: <21e7ebfd-d35d-4682-b553-6996cc8c3a8e@I-love.SAKURA.ne.jp>
 <e5c4f20159d3661984888add9c6da684623af3ad.camel@redhat.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Leo Stone <leocstone@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        George Anthony Vernon <contact@gvernon.com>,
        Yangtao Li <frank.li@vivo.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <e5c4f20159d3661984888add9c6da684623af3ad.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav302.rs.sakura.ne.jp

On 2026/03/31 6:45, Viacheslav Dubeyko wrote:
> I've already reviewed this patch. And I am not agree with this suggestion.
> 
> We prepare the key with HFSPLUS_ROOT_CNID [1]:
> 
> err = hfsplus_cat_build_key(sb, fd.search_key, HFSPLUS_ROOT_CNID, &str);

What we are talking about is not hfsplus but hfs.
I can't catch why you are talking about hfsplus function.

> 
> The hfs_brec_read() executes the search of the record [2]:
> 
> 	res = hfs_brec_find(fd);
> 	if (res)
> 		return res;
> 
> The hfs_brec_find() should found the record for requested key. And if the found
> thread record contains not correct CNID, then we can check the found thread
> record and return error as the result of the search.

hfs_brec_read() indeed calls hfs_brec_find(). But I can't interpret how to extract
CNID as of returning from hfs_brec_find().

  int hfs_brec_read(struct hfs_find_data *fd, void *rec, u32 rec_len)
  {
  	int res;
  
  	res = hfs_brec_find(fd);
  	if (res)
  		return res;
  	if (fd->entrylength > rec_len)
  		return -EINVAL;
  	hfs_bnode_read(fd->bnode, rec, fd->entryoffset, fd->entrylength);
  	return 0;
  }

Since hfs_brec_read() doesn't know which type of struct (one of "struct hfs_cat_file",
"struct hfs_cat_dir" or "struct hfs_cat_thread") does the caller of hfs_brec_read()
want to read, I don't think hfs_brec_read() can tell whether the CNID is correct.

I am waiting for your response on
https://lkml.kernel.org/r/9f66743b-70e0-4886-884e-5203f5c02ed8@I-love.SAKURA.ne.jp
where the caller of hfs_brec_read() can tell whether the CNID is correct. But such
change is a matter of preference.

You can respond with your patch which will be much faster.

