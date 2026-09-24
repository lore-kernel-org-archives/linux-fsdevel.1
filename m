Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com [74.125.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAAD424646
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2026 16:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790267327; cv=none; b=rsH3L0Cf+wOhDyNczFJgJrbSoDiTyU98VH1kghfo9ugQgMUOtG3gGCIXw/8dqW1k+IePqzq5bMKbpVMJOz6PndQrvFVpSmIJ72gzbpNfwecCECo60EurA7KErgd0JYobLiShV6qLL9q8M5S7tKs3Y4fFqT3sjqC/ZefcBt+/+OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790267327; c=relaxed/simple;
	bh=cxP7WPgYOcsOzTkYzBVH75a7X8pFNombS5dd5Fs4gFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=is4mNlDOCgY6Rrcf+HjJTBul3DisRaW5tY+AQ6Xas9tWYRKm8iP5pNPtQIBuuLUpT/nOLrA+hDpSZfnJPiMbOM1U9z632r4DlHMkrHRPU97A+Qf16drgZsMwTq2MMxnwqP3rqY9d2w3xss+eyIDMvCEbrBiuhRs3Se2XhGZ6Ypo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=UFJomPNn; arc=none smtp.client-ip=74.125.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="UFJomPNn"
Received: by mail-qk2-f43.google.com with SMTP id af79cd13be357-93910cadeb0so155188085a.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2026 09:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1790267322; x=1790872122; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vqnXyJFHA3jgUbjUAmybKoPJLc3QQSs1Be5SK9r4kic=;
        b=UFJomPNnGedUDMzL2JQqGfxFciFScmgvYi8OT5578HM7jjlXiRFqp4W076XAxgcQS6
         sHmK7pqVepM5TXUhqfO212jzkiCmPyyc40itZGUwyoSqYJPCXGDcnFT0bB0VQISK6H14
         jOIjLv2sD3bWyw3jHjrYUfvblbcmDXlQG9TpyAx4//15+DKMQXryA0EQLlaW6ybs6nIx
         aZJT93gsAfx79F07VydGRbK8Hct2hvTYHAA3e4vLlFqWIAJd1w+WQH1ec32IRxE9YrBA
         YzUpGnG1XfSpt6+aFRRlsYM9m0iqHeklawXLZE3mMLPqCqk+MZSbDnY1kLpHNNMMWSFF
         06/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790267322; x=1790872122;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vqnXyJFHA3jgUbjUAmybKoPJLc3QQSs1Be5SK9r4kic=;
        b=v5Eq0vUx7AA+Dzl0G0B1fSrH/plOGN0bsWLIGWN2bABe0D8gRTRRkcKImUv0qDz3Wb
         kqNpIdasGXFPCbHDuwaA+itcAE/NLlmLuYio9+hTn4Lh3AJtWfVA99C1J1mwtsvVpdSh
         SwCsq24Miu6UCVzbHj983Vf/YxaIH1f6mZCglgjtQAFM6LwK+x+emKUaB/fZU+GoBls9
         R3yNyuYjJd6oQXUfCPgKtUQq4YiEaFqpVk+Zmh6nJgytSfuXgwmdRlbk8ZL2GLuWvNCq
         rF+KFbh2UKPtlviIgHpB/Q9iC2rgZD9bzxMVbJrALMtjiMD60siDyvmi2S36IepFZumg
         pInA==
X-Forwarded-Encrypted: i=1; AKwUvBwevoHTPXr9Dz5E8gZMtZ5K1u0fVgLo1h8IdX+1mUq2kEtlzty2BBgok5HFfHMKs/UjXs9NyrISnl0hNNei@vger.kernel.org
X-Gm-Message-State: AFuF++kPckH3U1KnaHW2JaZsP+UuWRof4xAiZqOuQY5wZH9X7IyogO+D
	XNIr9aSoARt+ySuCsOY+LRc6jTHlyd4bq8OF4BhPHaopHVU0V9REOYsRqqbzLtgI2Xc=
X-Gm-Gg: AYBFou0HQuNeUGPJVR13gWwINvhedzhBuusWB6lczcqCVNbVO/YDNqI7GffSOnHIKov
	vIjKPd9HOzu59BZ/Yau1rj6H00oGI6K4g6bCqROE0o6OagFWUJGncWwzPcaLVhrZMBLJmuvbVxF
	7D5yghrKE3tv2PnUs+EEI77y9NXPNaq/y6S82nrjOPOoMjSnVW17DkgylqmN2a5H8mZ0LtTzNdM
	MsGii5YTS7YQAJeCQrUN9F2wI9pWT0Bih9RYw9asxyI/Hdx3gDVqsqZdYNsPdqFCvBcXZn7kkdZ
	D5E6P7uDUD8nmuLX1qupNyI6EX2ZgzHyZTE88SegpDtVIyqU6wRtNvjYAZVi9gEAUaasaJO/lNi
	g1vZacK5CRNRsE6QmHWnYi3QMWvFcvyWfR+tuhggVE+ryWGVfaf6lIxd7C8raaWzCjhzAObDMOD
	aj4dLDNciHqNxWCEzvoPsExsvp6H+ziMlK/Ze1XUw2G2D6HmI3A62h2ESISptnpZETgGRzRfM0o
	2f/uzngOV/n/jmO+NhQJFVyA3Qi17vcjVZf9IyXbWZ0GvQsa9zDcWY=
X-Received: by 2002:a05:620a:31a4:b0:930:9585:e08e with SMTP id af79cd13be357-93c362b2742mr373053185a.10.1790267322126;
        Thu, 24 Sep 2026 09:28:42 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c248223dbsm499338585a.10.2026.09.24.09.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 09:28:41 -0700 (PDT)
Date: Thu, 24 Sep 2026 12:28:39 -0400
From: Gregory Price <gourry@gourry.net>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oupton@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Michal Hocko <mhocko@kernel.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, Xu Xin <xu.xin@linux.dev>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 01/40] mm/vma: fix mmap_prepare file handling, remove
 file_doesnt_need_get
Message-ID: <arVOW_frpIU_JbbP@gourry-fedora-PF4VCD3F>
References: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org>
 <20260917-b4-mmap-prepare-vma-flag-sanify-v3-1-4583d8a23bca@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-1-4583d8a23bca@kernel.org>

On Thu, Sep 17, 2026 at 05:22:10PM +0100, Lorenzo Stoakes (ARM) wrote:
> +static void put_map(struct mmap_state *map)
> +{
...
> +	if (map->vm_file && !map_same_file(map))
> +		fput(map->vm_file);
...
> diff --git a/mm/vma.h b/mm/vma.h
> index e97bd2dfa786..f15faa83f3d6 100644
> --- a/mm/vma.h
> +++ b/mm/vma.h
> @@ -394,8 +394,10 @@ static inline void compat_set_vma_from_desc(struct vm_area_struct *vma,
>  
> +	if (desc->vm_file != vma->vm_file) {
> +		fput(vma->vm_file);


Sashiko pointed out that this could be null if the vma is "anonymized".

Previously we'd discussed that anonymizing a file folio is more of a
wart than a feature, and IIRC you intended to remove that (i think?)
when you removed zero-file mapping "anonymization" so some of this VMA
stuff could be detangled.

If this is an intermediate state, do we still need to manage this NULL
scenario, and when we drop the anonymization mechanism we add a WARN()
that says someone is being naughty?

~Gregory
