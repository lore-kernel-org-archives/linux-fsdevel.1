Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795195859;
	b=s2kiBPMpSZ3w06zxyNgvCmWD7UMlHypeCS2oo1+pv5Fsg7xLZ6JxXbel1onwsTlDCfhg
	 sWf8EpFcl2XsqU/6dRUBb4vm2c9/3o36VkNNK/2utiKtS+q6iLqX7IxRqrx7aCD9LpgH6
	 VIywPkRR7X067kfV9H8Cb0LxKPFnq1auYhSAi7duESbYrZ+eGTbySslAw25NO4p4lFLXY
	 SXj6OjZAIxDfdtsjYdx5Jf18eHNc9ZUJ//1SBJpw7HHQAQFB7E1xDl6UPkS0uoDWyswUI
	 gTskrfmAAF77U9Y59CwQCS75Spib6Ph0CAH+gtuFd+Z8dsknB1scxu4aKC71Pvqfulw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795195859;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:Mail-Followup-To:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Cpp+sFCicuYgf+c3zxc4haugV0ip6eM5biX4gD19sTs=;
	b=L5rxYuODw0cyB5uMkZFimc/8OQFRMDQ1WD+1jemvV8WoBVnDUy7knXrA9ouUP0/0EYGZ
	 uV4E3VyiECuvV1aBYAxVAIiJjsOSZQY0GZrBbWKow412+/Fvlpr+zcW2UB8f5Mqqxy2Rc
	 CEUM3LUsAWu48bjVzKcnf5MxKmMAqZFueFZEvh+Uk8Hq4jKHqKYXEyeE1mDuZBrhm3sbN
	 5okhP7WETHP+kLr4LxnZ5upxPaXaUCMkq9wmrma92Ir1u3/bnGC/Un5OrEA9keIXBgf/U
	 k3gRkICQMGaY3Hdqf4YuTcc6uZIhJnNEB+41DCX1TebFyqRsDhTFrF3FZcDpjIY8rGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.cmu.edu;
	spf=pass smtp.mailfrom=andrew.cmu.edu;
	dkim=pass header.d=cs.cmu.edu header.i=@cs.cmu.edu header.a=rsa-sha256 header.s=google-2021 header.b=hVD2xIA8;
	arc=none smtp.remote-ip=209.85.160.172
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF8560A2621
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 17:30:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AF8560A2621
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.cmu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andrew.cmu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.cmu.edu header.i=@cs.cmu.edu header.a=rsa-sha256 header.s=google-2021 header.b=hVD2xIA8
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-55c304f7031so13455761cf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 09:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.cmu.edu; s=google-2021; t=1795195855; x=1795800655; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Cpp+sFCicuYgf+c3zxc4haugV0ip6eM5biX4gD19sTs=;
        b=hVD2xIA8/rREyHY9Si7a/qw5Wd8nD0YUGombNk2V2ydWCXhxEPqJ7vR5Tn+rU1D2Vi
         tglykETYBfX6JkCKFNvnZ67IBYNwP7vfbSrTpXpDYto9iW6YunV3R00FWywjtCuBfpbL
         Z2S3t3dAY4GnD52x86KSRhe2JtD6ZkOLhHlwHCbizeuEjrfimHUtCh4CcaRzfTMq76VA
         1/2ViFygRU6O0lb3hVV8cJS9ZFBo2P4DYDtBrHpvhekegZXywFK/PmxgMLoszf7vuvXy
         zxVc4VYZ/DO8CYBKKw0+iIIA+mdlzp2pc8xh+v2rKB8VMaDlp31arkDZJMXoAfidkhax
         8ryA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795195855; x=1795800655;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Cpp+sFCicuYgf+c3zxc4haugV0ip6eM5biX4gD19sTs=;
        b=Aqs3p3QBRtcRPELrh6cYWR6wfPU0oUdodywhrx8eaRYD2PHAQZggsfaYYVK7S/zYEt
         BR8Q9YM4ee4LUOPqcqyVebfGRBKKs00+6GLzalS024iKWm3esw9qv49gclKNHx+hRW1Y
         TVNwoXmDVb1iyNrXwVsgwP7gF98V5NPWfkocVLpPT3M9+k3vDQ8w1zGlo9hkt0m0fTHD
         oxdras7B6kIUQ0HX9XxNHuw39ANcW5a/ziG6+/1VmojrQOc27BAy0tzWTbdeyt2mRKJa
         AemgoOXCaMJose6U3/93TAqZXcn2SbnjsDO8LyJrFKAL95ZQj7ZBksi8R/PN1X+bmEOH
         HDuA==
X-Forwarded-Encrypted: i=1; AL+hErFzVgZ5VSTpUFFqsFEguDaEU1A4/Ih8A9oChDNBt5KwZw6ktrfQHBnfWY2OCFsPP1RfP5L+4q5KCUOuikz7@vger.kernel.org
X-Gm-Message-State: APuU4Z8SyjdALOqOLTkkmqE2EcjHz7rmAk3TCmTllw6+3IHX1ydoGj+b
	313TLLI4/grw/+q+3JKureTniZOEsaTVuQtDCweT4M2Jhg7uueSyFpbGWJrbkXmvhQ==
X-Gm-Gg: AYBFou1PJzNE9WrV+rQq8piIUKekEN+ff3927kS5wzgLEINzZx1XKvIfDq26ouPjXCl
	Fa5qinsIP1w4XZmZxV/w9gEhWlJaowqwr3GN3v8ZIPRoJGi7EV0SumJbV02qx1QBkRAdRt3ya8l
	Jk81VvYS5SUVoN1aSdOJwGA6cbADwnkvzJ+nGWPwRWj9teoCvYS1TgfckuDo4o+iVpfdgMArh6C
	A1iUyJDNIdKuZ426GuYGDe2yB11HH0fsYRvGAB7/MARFVy28nDE5sLuHiV+yysePGVcVwnBfdfg
	r0oK7ATZlgHLvPHZJuv+CwW7mk6o0O4VgWqhRmx+AwPxGxzK7DJOiYpdhh4Sccjg9re3VNJ4nIK
	wtzLqnoKxdOfWQ2Sp6KQElahFE9gPud8Bz9P4WG0HrYB+tIuqD7jVBqPOVTttW4aDC29NCMoWT5
	w/ciHrcwmdm+s7HmgB6YYGakIUug/atyp4gND5nPIwcxQAHeUmJa5S3HLdPXfOxfLxQ5agrl1UF
	WBk7OPEqqRPancDG+R8JOFZDQEZAUyJbV7D9EBAuNcp6lBR3i3n9sEQPFvg5dJ8YH22gaOHL8l7
	JQAhdSpq74P09IXaLJCjtoZKlg7XKo+h4u/RDtFKmE6R8SvAw38=
X-Received: by 2002:ac8:5d0e:0:b0:535:1d5b:a7fa with SMTP id d75a77b69052e-55d769fe4ddmr65344931cf.14.1795195855134;
        Fri, 20 Nov 2026 09:30:55 -0800 (PST)
Received: from cs.cmu.edu (tempest.elijah.cs.cmu.edu. [128.2.210.10])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d7882e32dsm28152341cf.13.2026.11.20.09.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 09:30:54 -0800 (PST)
Date: Fri, 20 Nov 2026 12:30:41 -0500
From: Jan Harkes <jaharkes@cs.cmu.edu>
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>, Carlos Maiolino <cem@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-um@lists.infradead.org,
	ntfs@lists.linux.dev, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 2/4] coda: don't d_drop() early.
Message-ID: <20261120173041.bd3xeidt4ndkmimd@cs.cmu.edu>
Mail-Followup-To: NeilBrown <neil@brown.name>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>, Carlos Maiolino <cem@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-um@lists.infradead.org,
	ntfs@lists.linux.dev, linux-xfs@vger.kernel.org
References: <20261117000115.1433875-1-neilb@ownmail.net>
 <20261117000115.1433875-3-neilb@ownmail.net>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261117000115.1433875-3-neilb@ownmail.net>

On Mon, Nov 16, 2026 at 07:09:14PM -0500, NeilBrown wrote:
> From: NeilBrown <neil@brown.name>
> 
> Proposed locking changes will mean that calling d_drop() could
> effectively unlock the name allowing a parallel lookup to proceed.
> For this reason it should only be called *after* the attempt to create a
> symlink (in this case) has completed (whether successfully or not).
> 
> So move the d_drop() to after the venus_symlink() call.
> 
> Doing this also means that if the upcall that handles venus_symlink()
> happens to look up the name being created, it will get -ENOENT rather
> then a possible deadlock.
> 
> Signed-off-by: NeilBrown <neil@brown.name>

Acked-by: Jan Harkes <jaharkes@cs.cmu.edu>

I was sort of already assuming that the userspace cache manager should
never ever traverse into the mounted /coda file system tree because
there is only a finite pool of worker threads. But it is good to know
that this change would fix at least one possible deadlock.

> ---
>  fs/coda/dir.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/coda/dir.c b/fs/coda/dir.c
> index a85be5962e62..b47299527b65 100644
> --- a/fs/coda/dir.c
> +++ b/fs/coda/dir.c
> @@ -249,13 +249,13 @@ static int coda_symlink(const struct mnt_idmap *idmap,
>  	if (symlen > CODA_MAXPATHLEN)
>  		return -ENAMETOOLONG;
>  
> +	error = venus_symlink(dir_inode->i_sb, coda_i2f(dir_inode), name, len,
> +			      symname, symlen);
>  	/*
> -	 * This entry is now negative. Since we do not create
> +	 * This entry is still negative. Since we did not create
>  	 * an inode for the entry we have to drop it.
>  	 */
>  	d_drop(de);
> -	error = venus_symlink(dir_inode->i_sb, coda_i2f(dir_inode), name, len,
> -			      symname, symlen);
>  
>  	/* mtime is no good anymore */
>  	if (!error)
> -- 
> 2.50.0.107.gf914562f5916.dirty
> 
