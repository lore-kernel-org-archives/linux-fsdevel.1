Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E423B2FED
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jul 2026 21:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783718053; cv=none; b=enMEDWUnSs6L/dIxNI01/TcDe7o1N/SHqhd1D/EM88mXg69WWrK31PpW5+PtPg/tHtikAk0UmgXe33wb82nOJGUHJWSziZCxccrhUK7/YDKxoKKMySqH2f1bdlzgDXbqKyjx7/nRexqM53vux+H708rslfR2JbyOVGffAJM2dpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783718053; c=relaxed/simple;
	bh=K/lBj6p3knKpn1KqMVCf0Kk2GjXtTJbSA446pc7gvzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a/dOb1bcyFSvGbt2Bw683YiRmp6gvOWHqihbCQ538b8INyfot1VYI3mhOsCK7Q3B1tQ4kixXqpFiI4U+iMlLYl+BsNHaktXcCChkuNRsvspCZ/SzTnuZed+hy4oZi77f3AnVxd0P1Zfq6fZwxngse3yuiFTKUw5aBb/ufka0sHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=bfIW/6WN; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="bfIW/6WN"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-92e50979c71so135257785a.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jul 2026 14:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783718049; x=1784322849; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gpMGBsh9fToTErr7i3jlVPE4gbDMnqxhA+rLBjZ5wi0=;
        b=bfIW/6WN4DfK4HmG3EwNlYAiEHTPSmfAPM2seUXbEKJRrAhqbtqQC+bGvJRGsgGDsJ
         KsJhZF5oBdEk1wa1MnmQY89PLgNUEI2m2vqVI1zw65BwOubiYdgnsNW9de6u7OHSnXoc
         uswcZK+JlO+QXFjPXzsXkppZYO/EZ49C3td5CWj2GNlm2AcI1ICvrsjMwZ7VGfc2fStj
         tJICWPLm0/zgbmVGO3mS2PK/W4yYCBnfYTb8wjwn8ySKcXc89ktEAiz1rk++mJ6ZIumu
         DjeCGHbb21rWZMPX9M68zrHbxy9uTfpNhK6zpyArnPu/aDVei9uwB8hdjuoKXDgufhxW
         Fi2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783718049; x=1784322849;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gpMGBsh9fToTErr7i3jlVPE4gbDMnqxhA+rLBjZ5wi0=;
        b=r0BSoMMmFGt7KSGcJs8kiQtFSXHr742w9pYhro4JgU/F4KHVBj9fjEoPRuu8T0vt2U
         gfFuIafF2J8ofUw84UN8PUTycZgbS6TWAzFVmCgepTr7uudviiN03mS+1p61jTfw/qul
         C5iYdok2FjF6wtmg+HMIxKdnG8gKz+IUNjY7fBMboju9Oc6QUWoH2lzCOsUcaDy3rOUK
         pmqu5bTeZGNJadEi9T4cxFVCZpaV84xcU1RVeA64KrHrFWhh4PjFnFoncr0s8gJJnVNI
         XcsMqs2mch2cUEyNXtRc0w8eB+LM4E3fLHKwok/lyXl0sWmrevWfVRfTb1Cx24XPSFEs
         OMng==
X-Forwarded-Encrypted: i=1; AHgh+RqFcAQitHEbojMnyH9aO6UOzxCYOETT+YpyjrDlwjOBaBEtdlqNzO3e6TOI6sJMZHP//R79xhEfeZTiKtzm@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz7N//GHnSG+s2479Cza1Qmxqwb7rD52ZIF+HVNZuMVHg+DooC
	I1V5KX7phtINiJdJlsN7jsWPfRpJO9VnLRHG8Emb+LJGX+kIGQQbATdZKBeCV0FNv/4=
X-Gm-Gg: AfdE7clc10j6+xywtnS/ooEDLKvx2+zxuQxPAIqEmUa4U2ETP3BbN1BHoxolU9WoY9G
	SwvugQXyeQkbHdR3iLgrf2b/fQ20tkfoU+Zryzqa//JBiCC5UBib631qBgmLsV2c3WlqJewacSd
	apm2vip8c2bZ4AbPnNFhENZjHjSgod/cXE4nPHOP88s5Ghy9Pmipbi+RGKZoO+Sf1xUlg4D1c8+
	t6ApUB8GgC2pvCfabuQpOrbS5lHH/WfNIQgq45+9X78blaBGF/0cqz3QM7oiXH6kWg/Lnx2efLK
	ALJ5aeXUwCq2A0sThG155sfRpybFDILcUw0v2Hm9wElPL5+LSSvCxtLYSMZ3u1meLuUKn2mOQbq
	lO9O3X6EvISWmOXOpcmUDxZ6jdsygzZoZvkz2qJ2PvuklcHoPVK7pqdWTTgXx+THEcwGVvJDrKO
	49YDlpggkBWY3qOP9fgWXEaWjdbpEYg5HaPtjmWTaOcG5EGLuP4WC4RdWAEmFCkQV7m2PM
X-Received: by 2002:a05:620a:458a:b0:92e:c117:9ea2 with SMTP id af79cd13be357-92ef2e264b0mr94774285a.80.1783718049159;
        Fri, 10 Jul 2026 14:14:09 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd50e3083sm50604746d6.6.2026.07.10.14.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 14:14:08 -0700 (PDT)
Date: Fri, 10 Jul 2026 17:14:03 -0400
From: Gregory Price <gourry@gourry.net>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>,
	Harry Yoo <harry@kernel.org>, Jann Horn <jannh@google.com>,
	Lance Yang <lance.yang@linux.dev>, Pedro Falcato <pfalcato@suse.de>,
	Russell King <linux@armlinux.org.uk>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Simon Schuster <schuster.simon@siemens-energy.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Dan Williams <djbw@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>,
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Christian Gmeiner <christian.gmeiner@gmail.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	Christian Koenig <christian.koenig@amd.com>,
	Huang Rui <ray.huang@amd.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Ankit Agrawal <ankita@nvidia.com>,
	Alex Williamson <alex@shazbot.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Usama Arif <usama.arif@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-perf-users@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, damon@lists.linux.dev,
	iommu@lists.linux.dev, kasan-dev@googlegroups.com,
	linux-sgx@vger.kernel.org, etnaviv@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org, linux-tegra@vger.kernel.org,
	kvm@vger.kernel.org, Russell King <linux+etnaviv@armlinux.org.uk>
Subject: Re: [PATCH v2 10/33] mm/rmap: rename anon_vma_interval_tree_*()
 params and use pgoff_t
Message-ID: <alFgm58E4G7hWIm_@gourry-fedora-PF4VCD3F>
References: <20260710-b4-pre-scalable-cow-v2-0-2a5aa403d977@kernel.org>
 <20260710-b4-pre-scalable-cow-v2-10-2a5aa403d977@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710-b4-pre-scalable-cow-v2-10-2a5aa403d977@kernel.org>

On Fri, Jul 10, 2026 at 09:16:51PM +0100, Lorenzo Stoakes wrote:
> Rename parameters used by anon_vma_interval_tree_*() functions: 'node' to
> 'avc', 'start/first' to 'pgoff_start', and 'last' to 'pgoff_last' to make
> clear what is being passed.
> 
> Also, express page offsets in terms of pgoff_t to be consistent.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Reviewed-by: Gregory Price <gourry@gourry.net>

