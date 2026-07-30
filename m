Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F2833D6EA
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 03:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785382333; cv=none; b=mnWSjaEckZOH0MWbY/djMrU4nr1YVB2cSc/ZYf4Pe2FpR5hUggzLpmnLJT/Uiwfgb9LK9n6TowZOarsVzgF2e/kwI8ZWv3Vwu/2q/iCjzD2UF/klH8i9IBbucIQoSQ8CmUwBLas7yudtcT+gDOnNJf/GnpOJknT8f2D/12sfWgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785382333; c=relaxed/simple;
	bh=V8PGeWeyokDrNTSzkeX0jP1Wwsix/DVehHwbDVareWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dBEpRNwZ7UMnuuJ5LGdkucc8d91bqpXN9b0HZQ3mGOmu+AFRGvEQJdUJtq19lTMVsnDlmKHcEOSZlD1QRHqXn0K2rYCau5iIOpbOreCAjx2QpPery8C9UY4l4rxREsx5SD9MaZoklsARLqTTzqxkuk4ZgKx4SkZuyGk0SzzbKu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=FJOXcIr7; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="FJOXcIr7"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8ee43b3e5abso12108376d6.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 20:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1785382330; x=1785987130; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HJ2tPnxbrcFKcFZzwn864hCbrfOqlBJ/Hk+311dwGeA=;
        b=FJOXcIr77Ck9WU5lIz1XKl8wt0M1P/WB0i+NClo1czpP0tyf3qiQiJeFFHw2Yumbj5
         EP3jyHB407dAb4Wmb/BM8axIqZecYdKUvtrRCGQ3um4YpEvqjk/dQdXnyUOLNbzTFxMZ
         +LotiaZgwOKlEj3e80/PPwQiq+uSlmpEKLCTeEd6qDtwU3AlvjBr4uewcuyyVXvEM91F
         vkSmX8wjCKFyYTIf2jzof6weHIWEhokGXu33ebTUbQYAyE4dYsXMqwhZ/ZrAHd4TTTan
         qS2KM1AtgpkbI17z0dAioxxW2v03Vf0tRMNGLAxds3as7Pg4a1B9FIc1stFR+W28llRi
         cWkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785382330; x=1785987130;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HJ2tPnxbrcFKcFZzwn864hCbrfOqlBJ/Hk+311dwGeA=;
        b=DSg/iNUbRMgmRaGGOIiw2SrWUuQMKy3a6qltN0x/wff9VE3VnmpZtK3FFOHOuUhy/U
         GRYHFiq/SiSBuPyqQDEv8Pt3mshuDh1qble9CaxDLPojl8+7LOPSQ8Y7+ytd/5dYb3q6
         jmMG70FNb27i6Wt3is/Jt5Sk5J5EBEYZUmk5vJ3V0XYDHNXlDOp4xM0uW0Xto0S/7fsR
         72nIL+JEuFBqSYNmv75Q5Z18Ek/Jtn5zMRguihhb/IJntxrUvMHdS6ZVXwZOdbvYqxBe
         2XWnBQU0+cyVICb2sR2nD7QChTMbCw8TdThBBLHT8liT1rUDLPQAotcs6BLo/ErAS3VD
         oulw==
X-Forwarded-Encrypted: i=1; AHgh+Rq5BF23BccIUMvvwA34DHGavXp9ifzpySXtovZzt7ozl1hgPegT7zOPuMhz4cq/R+eLCDIcCE5emxWieodp@vger.kernel.org
X-Gm-Message-State: AOJu0Yz52pRb9YZyyCPpVAJv8RAXs7lUOr08t+GvAbwq6OYvs4mxKW1Y
	uk5v8aDRjLPoyPkwhbFLEHcdLw6sahtaSfDJBY9YutnNeE+O507BYmyzklidXbD9VgM=
X-Gm-Gg: AR+sD12EpuEurpVBNB0opO7SRlOWg2Mgt0hT0E2TYM4v/c/KJLbRmZtB0CcUXXyRaNL
	dGs+n498urWM/wU/mLWxbY8ev1+LKKhbj2WwZk3OV3EnnflycEkE37Hwhsx8r9XmA9MGEvmsSsX
	FtgoP9EzXYKv9s9jNWxjkBRicYx2MhIHzSKy+dM78WlBnQocF3lLfZ+ds/3fzYHLLJ6tmyDhcx6
	ANaloYXYAeNeyrDF7fnG97FfTVEsilI+XUuXOw/EkbRrL27hM3Ewajh6y3TbKyAlASn7jWuoCR/
	MnWVyyqMojwGGHNI8n2+mw8PywcPlH4d01S71us/dtacL4BFdDuS5AHTo2KnCaGnS4+vLQ1Sikb
	WUeh2Ae+myT8t4wwO0UGuMS0dktXX20Ete9KtJ6u8d/stDyMuu3/NnLeIwYtawb1/zgv0ZUV5mu
	CDpnbXk7ufz5O5ud5Aed5ZXXgHBNgXwMfE+3bRXqBBl4PVdyPOk+Jw1ThYMptjiei8+zLeSz2F0
	invycIMib3H/WTFTGtTXS3StsBzMDVPdBW0Rmm7jVyM
X-Received: by 2002:a05:6214:3b88:b0:8ea:7785:f3e6 with SMTP id 6a1803df08f44-908347b2701mr8202616d6.42.1785382329952;
        Wed, 29 Jul 2026 20:32:09 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-908323eb01esm6949626d6.30.2026.07.29.20.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 20:32:07 -0700 (PDT)
Date: Wed, 29 Jul 2026 23:32:04 -0400
From: Gregory Price <gourry@gourry.net>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jan Kara <jack@suse.cz>, Miaohe Lin <linmiaohe@huawei.com>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Kees Cook <kees@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Usama Arif <usama.arif@linux.dev>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Peter Xu <peterx@redhat.com>, Xu Xin <xu.xin16@zte.com.cn>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 01/15] mm/vma: introduce VMA anon page offset field
 and add helpers
Message-ID: <amrFcza2MxHb2cTX@gourry-fedora-PF4VCD3F>
References: <20260729-b4-scalable-cow-virt-pgoff-v3-0-e8ecfefea812@kernel.org>
 <20260729-b4-scalable-cow-virt-pgoff-v3-1-e8ecfefea812@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729-b4-scalable-cow-virt-pgoff-v3-1-e8ecfefea812@kernel.org>

On Wed, Jul 29, 2026 at 05:48:36PM +0100, Lorenzo Stoakes (ARM) wrote:
> This patch establishes fields within the vm_area_struct type to store the
> anonymous page offset of VMAs.
> 
> The anonymous page offset of a VMA is equal to vma->vm_start >> PAGE_SHIFT
> if they are unfaulted or were not remapped, otherwise it is equal to this
> value at the point of first fault.
> 
> Currently, anonymous folios belonging to CoW'd MAP_PRIVATE-mapped
> file-backed VMAs are tracked by their file offset. By adding anonymous
> offset as a property of VMAs, we can now track them by their anonymous page
> offset instead.
> 
> By tracking this, we provide the means by which to eliminate this
> inconsistency, and more importantly lay the foundations for future work for
> the scalable CoW anonymous rmap rework.
> 
> This patch simply adds the fields and some simple helpers. Subsequent
> patches will update mm code to make use of these fields correctly.
> 
> The fields chosen are packed in the VMA such that, for 64-bit kernel
> builds, no additional space is taken up.
> 
> The first field is present on cacheline 0 containing key VMA fields, and
> the second on cacheline 3, which contains file-backed reverse mapping
> fields.
> 
> Given the relative time spent accessing reverse mapping fields as well as
> updating them, there shouldn't be any performance impact here from false
> sharing.
> 
> Update the VMA userland tests to account for this change.
> 
> No callsites are updated yet, so no functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Much clearer :], appreciate the rewording.

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

