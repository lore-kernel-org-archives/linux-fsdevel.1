Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795657633;
	b=qX+woegSg2euab5Y0wB6ClkbZawn0PJbCyfa4hyneMvrcfjJaxJO1HGZtfuLkRZJCZk0
	 BFNiaTME/eqkOn6tm8fIC0mXlpT/08IVCsr9loxRj7h7uaIlxxeGyYXr8AFxjY+qwfnT0
	 cwjC7cZw4hJu4qCq+lM4iDNRHnZvhMprKZp/Uji/JzE51gGZwo9F6QIhq8AE+UWSuuxSj
	 wwjzjOWibmpZcxAhXS/CTDWvyW4lU34EmR4cghV46UuP/eyJugpA0CnoC/6f3fFwD9T/D
	 HDwMHR49Rp9RP9ZW+P3xVru4ZHSTrmm7tzUXBt92elQ8rM7x3mr6FCMjuu2hoQiGdQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795657633;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=C90z5eRMPRz7rm9tSvRsEhi09vVmUDZ/4/9fcRwxuPA=;
	b=3Vtjo/medrtxQcfWrtg08I29OLLLSz0rogf/PCmTP3bGlZqlrkcIXfDA+mYbgDUVRsAI
	 CTEh0+Q9vgq5IsB6Dai6RTNkUvyp+6ZykKsBAmVj0Erbkp/AjAZ0k66rWhy7gxThxNrMT
	 XF7FOWK0U43BUA+O43RWCjrkTRbmskl0Uk6U29jg83eI2wrWOj/OrqvOJVSsYx6WEN7SX
	 43C8PaDTKE2KQdYZ5C+3ziavqKq4zdNN3ktuShID6lM3VNu4mNQHDzuel7nS434BdOkG6
	 B+f7IORXdCYPT4PnVf+lQOVxHzjCYIPX/l7/N3UrXkqh+Rctuyr75h7OmtGAez9x4DA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oiiwp6KB;
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21568606A329
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Nov 2026 01:47:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21568606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oiiwp6KB
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3b41188c8b9so4573889a91.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 17:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795657632; x=1796262432; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C90z5eRMPRz7rm9tSvRsEhi09vVmUDZ/4/9fcRwxuPA=;
        b=oiiwp6KB2jn07gDx/FeG7aU1f+cY9kbOBZNdBq5aYpcBYZ78xSSKR/mxWqZO/r73hw
         yq7Kdk7Dg/qQoOJ+jqaJdo0XtVvNtAqdDsOMvoGExjRRMGcuuPZXMTME17hBDF1dOoXl
         dEg3TW4UL83EdVZNI6v8h+XR6Rld0UB2hE51BmauDmP0myrykmjoFLeUScN7xKnqV+jA
         RfLak4V+WPIlZt7qyeNJM4zAsOj9RUl611Jr0Wz/Z3Ezp8VcTbxMLcWTIKFJdoHw9uep
         mWYnJ1RKv4MmMB7hX60Sms/d/Sh+w+K5aJJwGzdU2OIKxyt6x5V6XkrJcGilmJKrFzhE
         kSpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795657632; x=1796262432;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C90z5eRMPRz7rm9tSvRsEhi09vVmUDZ/4/9fcRwxuPA=;
        b=ynAUmxmpzl8ZcGcVstg5nGaukFs7qnYNvGk44nRPo/7dYP3fZIbJxrQBDNFp3N9XTx
         xrrUMsXMglp91OnZe0wgp4NTMAJLyUorQhBTxaFwckgHH7V6snmKZu0FEsf2uzXeYA1e
         kokmQNMENB1Vtw+tK/9fbJjWTgIKM7ooiBQS/cm9oBbKCi9q1/4d9KKXl5TyLeSe37lH
         HZKCKybL+hjKO7ErF0yAng5JlojQfCfthcKeGpk0E7soG5jGT6UIXM8CqbuhHM80g3QX
         Rzo2wVbmVNZph5zfDvs7Y69N0yEGSCpW64w45F19pCNJ6WM26up2DLfYCj02iSID1gTP
         GV9Q==
X-Forwarded-Encrypted: i=1; AL+hErGziGcIGBc33EEJO8IFLFMIUCCgdu44vQNe13hr+tsgelRBkEC9DnVEJUZmoUl30y8HFVNi2h4205kDxY1X@vger.kernel.org
X-Gm-Message-State: APuU4Z/8QkWBis7mh1k65/g14Mrv6VMhYGUqob72p3jLiqPPgN2fNyd4
	9r3+xgL6/qUzHjGe/bg5OGU2TPTCKtS4ZeblRAqk3FsvFO/g9/MzP5GJhvEQhmmB
X-Gm-Gg: AZFdTZfOBHZowMZtl+0iD9SPHIjHXie0rjpQPqmUJhNLcdHacoHa7LmzxCxGTyMsxEs
	vF7b1QBFJAbZY4l5BYVUd1jW4YezSplRAz4RMBO6L4NSwylovKVdodUlCPltQoULXsBnl+NAdD5
	78WYmPevE4Edvfhp4ymPqE/MK2otOQXv6rE0zpFNP71q2A9Freh0nfxdk43MSi9vcv6ebn0+uj9
	111gb9Oo33c4Q4NRgYTFK0/FzX/DKHUe+IOQ9jqgJ6Imvj8qIyO4hbOlmu7gFFeUonfYBZvhw4V
	/9LFcV1YRtFkt2nyuiZH6xIOxFBAiqREB5ezhzsxDAjTL95vOrRhPUA7zNAeAG8Jdy+4FEHCEVl
	/tt7HtQTnWN2zzG9jNE67kwJUgcOvvAzyY39qgraiOt8gKmjJNgwujEpi9/IO35/cUy9FlPtuyt
	X1CGbIixfcCC4LhnVqvQqu8ZifxPzRdw9l+4DN1kR7WBBaaWuLYGrS9mksxOSGXUutWY9KR3J/U
	Zx5vZAJ2pjzh6y412l2nKS5YNYvP1E3qB0c6esQAkFam/7YVSRkMk4Pt7se+mMn0SW29UC6ZctF
	ux1OWm1XoEwgHa6fjaEqc/5lwRULcOfThcz34Rwt
X-Received: by 2002:a17:90b:2c86:b0:3b0:a9de:9886 with SMTP id 98e67ed59e1d1-3b41c8d9179mr18731494a91.12.1795657632334;
        Wed, 25 Nov 2026 17:47:12 -0800 (PST)
Received: from localhost ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6cfc6130sm10007818a12.7.2026.11.25.17.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 17:47:11 -0800 (PST)
Date: Thu, 26 Nov 2026 10:47:09 +0900
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Showta Ishizaki <zakinko@snowrabbit.org>
Cc: Namjae Jeon <linkinjeon@kernel.org>, ntfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ntfs: keep i_size of a directory equal to its index root
Message-ID: <awePnaRhBQLahPpz@hyunchul-PC02>
References: <20261125-ntfs-01-v1@snowrabbit.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261125-ntfs-01-v1@snowrabbit.org>

On Wed, Nov 25, 2026 at 11:18:20PM +0900, Showta Ishizaki wrote:
> After mkdir, stat() gives a size of 0 for the directory until it is read
> back from disk, where it gives the length of $INDEX_ROOT.
> __ntfs_create() opens the index root but does not set i_size from it.
> 
> When the index root is moved out to an index block,
> ntfs_ir_reparent() updates data_size but not i_size, which keeps the
> length the root had before.
> 
> Set i_size in both, as ntfs_ir_truncate() does.
> 
> Without the patch a new directory was 0 bytes and became 48 after a
> remount, and one with 300 files was 248 and became 56.  With it the sizes
> are the same before and after.
> 
> Fixes: af0db57d4293 ("ntfs: update inode operations")
> Fixes: 0a8ac0c1fa0b ("ntfs: update directory operations")
> Signed-off-by: Showta Ishizaki <zakinko@snowrabbit.org>

Looks good to me.

Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>

-- 
Thanks,
Hyunchul
