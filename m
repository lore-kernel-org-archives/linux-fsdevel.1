Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F88E503BC9
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Sep 2026 16:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788797098; cv=none; b=dA4DcVvbTSKyHv70EXW3Hb9Fd1mm7BTrkJZ0mC3A7DFxbDG62nr9ax8JykoB4gCdgFbFHVkm/ttudmtfuCDMHc/kcyiCpdpiOAORzStZ932B0JEtN4SJxnTam8uPKmQcxfwi0frdebIs9az+EctgcY0nft6m1ymUiQh01m2kHnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788797098; c=relaxed/simple;
	bh=7oIcXSH1gZ5pYqSF0p9nTlhpOlZssCHFCItFtSVIiEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kVwZp0P5KzjVZ2zROHR602UkMmgxIJVuoKTUTqEBW0tVU8aruJia2PW9/Z5Z2cJaqxplI43oGz6M6nfUJB46RgVdTI7De+hgTq0McVABOtfIs4aLnbfb/tHnZdz3T1INKwXuizsT8jtKY2zf8m+PGwCmD1RNsGlOqYuNEGgIMp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=mOUSZR5a; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="mOUSZR5a"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-939b8a5584eso12755585a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Sep 2026 09:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1788797093; x=1789401893; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FNnTBID4g9aytHQLyfm+JMBPPEsDRdj9xryUeJJj4sA=;
        b=mOUSZR5a+jKgEMol0Hs8T8xctZFoniizjw9yko8/lHt97hsjjdfh8H7JdITzhH6RcU
         5OvNOf0yAFXzE7AuVTc9G7P6IvObGFJwBL6dex1xECb7ayQfii1sudbg/Uun3yNd36oL
         sIFj/I8mpNtpWcxQzh9C3hu1H5R5P6lRSZfaHzqCopL+6JqQh36zGC80U4GzPsB4D1cw
         FL56uRQUPbCvEVLlOibqAAV2R8gtzVn7Sesoep7Iq3/ncQeP6LnZr3EMAoGbFwRlUATS
         llI5GxdxOcd0lGXTrjb7r4/4oIpXZTkGE3yB5B3dWUWjuPpyd2V3cIxRi39qqHL+eJ0V
         HWUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788797093; x=1789401893;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FNnTBID4g9aytHQLyfm+JMBPPEsDRdj9xryUeJJj4sA=;
        b=TbWkS5ga9t94bZQinG4ghZhPV5IWxp6lh61WBtiegvO2n4hEWkcAu1WPA5ZrPc4X8w
         Oba00o/ANA8QsumHO7KPyoHi7YM/OZtpobLj3XhdOAILXd3FLKP5kziov+/2Vz3wenng
         7X8n+mJ2gQ0R42EmCtkF9u+o8iv7qID5wPTquGE/XBgGJT4c7PsxTKG76aaoouIBg4Sw
         2V9lr/m1hy39buS4vauVgFuZuYmjS0ISGytZtI3famM6j6lnfX005wKD4vV9pJrWOz3l
         aHNR8h5uhHmlX0Jhbk8l7AahVH7wXMHHx+Ju1zh0n8+LHR9aTgiI+9VrozDO8fnLXDO0
         b7CA==
X-Forwarded-Encrypted: i=1; AKwUvBwz7KNDEzzN/xG71J3rgHyuR10idPnGSEQcxUwsMb+wPVp6P4muixSvKRxBxYeI47smUkdZLf6sMljzeugh@vger.kernel.org
X-Gm-Message-State: AFuF++ln+ueVEwf9kVSepVxCLkarBtNEfHToioaaX7XdZzEVhMOQfHF9
	kMF0cngSUMqmQSVxCNZ3fhXK/iOnlgfhxwW8kYmHh68D1iI/xJv+otgJVNcb3xvJlps=
X-Gm-Gg: AYBFou3HjZYPHnvt69itKU8FJrv/yY6JFCb8XoSCgr6di5qm7Bepzho0Zb94HghuId4
	BhO/K0U4S1S8W24UwErMBSRxKZ92IdjfE6poLQBcxXKRZivmk/DdhDaTo76kgBTGURImM8xmfR3
	0DfzSRGgGlKaDic2cwqe56AqxE1jVW2j2iprvc4Mh6+00CjsoufR3GkcQ51Jpc5c3Ut5wQ/h16H
	K86WhXpdG5GIHYP62qJwQaECZTaZ55+9sNSEvWFiQmoXex0v18Q6pVbJm/+PZ/B3McW1Ogj9KPq
	R/+aLvhF3OCmMpxSMEgtCvXwOvS8TjTdI3itGq6BTtcCVtDX2lKwXnB0nhHYJDvgDL3khdGVKJR
	IJLfyT4z+jkAuduDemug2upCNMyW0selX0fOY+cJgHg2x92/dK0u6XN9pNYmgX3XFWIZm5C8QmS
	2t5Bhyt7m+HvMaE1QU2/kATImSPsEKtp5RKg2hcilLe1eNhs8nr9JO9rdEqVU6rpDrWtOwOhrCs
	bJrT0CB3cLP5hxwWFQf8V3m95tILCK1CiUMs+S2C+S5
X-Received: by 2002:a05:620a:a38a:b0:939:f89:3688 with SMTP id af79cd13be357-9398048b90emr1959600685a.42.1788797092662;
        Mon, 07 Sep 2026 09:04:52 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9397fbb70f1sm932389885a.40.2026.09.07.09.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 09:04:52 -0700 (PDT)
Date: Mon, 7 Sep 2026 12:04:50 -0400
From: Gregory Price <gourry@gourry.net>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 3/6] mm/vma: only permit MAP_PRIVATE /dev/zero to be
 mapped anonymous
Message-ID: <ap7fOu5DHkKtqlkg@gourry-fedora-PF4VCD3F>
References: <20260902-map-private-dev-zero-v1-0-a578c730cec7@kernel.org>
 <20260902-map-private-dev-zero-v1-3-a578c730cec7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902-map-private-dev-zero-v1-3-a578c730cec7@kernel.org>

On Wed, Sep 02, 2026 at 07:00:20PM +0100, Lorenzo Stoakes (ARM) wrote:
> In order to use mmap_prepare() with MAP_PRIVATE mappings of /dev/zero
> without the success_hook hack we explicitly permitted mmap_prepare handlers
> to set NULL vm_ops.
> 
> However this is dangerous and we really only want to allow this for
> MAP_PRIVATE-mapped /dev/zero.
> 

"this is dangerous" -> can you expand on this?

I had been experimenting with mmap'ing kmem dax devices as a way to test
generating a driver-defined efault mempolicy on an anonymous region, and
this exact pattern came up for me during mmap_prepare trying to get rid
of the "fileness" of the VMA.

Basically looked exactly like the /dev/zero vma.

I understand this is a hack, i'm just trying to better understand why
"this is dangerous" and it shouldn't be a supported pattern.

for clarity:

   fd = open("/dev/dax0.0",...);
   buf = mmap(fd, ...);
   /* 
    * mmap(_prepare) callback marks the vma anonymous so it takes anon
    * fault routes and sets an mbind mempolicy installed on the vma to
    * prefer the node the dax device is registered to.
    */
   buf[0] = 0xDEADBEEF; /* faults an anon page from the node */
