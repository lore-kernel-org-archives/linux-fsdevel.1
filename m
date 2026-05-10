Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6FD381AF9
	for <linux-fsdevel@vger.kernel.org>; Sun, 10 May 2026 12:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778417174; cv=none; b=rNDDxwTFcepvS870DsY1IHH6rAQ/32qy0Qb2AatkE4nGYi+Bug/rhRWPDse1lpWkIWIS13HToW5OHfyc8GHAyDVwWL70mR1gMSAbiEVLeKs68J57015B/+fBfgaUkdcAVd668A1KqSaZJ9Y3QYsVMvM+wvPTOUNR26Mb3mWiDxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778417174; c=relaxed/simple;
	bh=/U1OGiIhFyZSlKY7wTyol1P7vOiJDk7Vj7vPDCFCKgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H9vBGvV9DurMhMahpnAc/W+z109b9oBWozi0kOXVQpOx+yk5Pj3SJvqCtaZFtqpaCS2oiBFHkfcQWPoXchAy2rZhZzf5CiRZLMdMqolyTAklRU5Q6THZIluuCT6hry+0HOVNMhnxmuqIpCxraD57Lk4mr1jXKpAeoY5JUm23ZPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J8hTKKET; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8hTKKET"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-44e5624c053so1904725f8f.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 May 2026 05:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778417171; x=1779021971; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9UiYX3DX2mOcITjXbonrx4I6NoJQHM2UHkbJQh3OAx4=;
        b=J8hTKKETJjc8eL73ki7wXrXCBvEu07QIoLgG2tQ7a5m+KtOMvmVC9bCyD2ibr6T0yK
         O8+FtAw7ex4vyQMq/woVcjUJRNblfNXs52mDsGE1POtuTkAa++CxOFktjjgHd6zMWXFW
         k2VMOr0Cp138EuM2IldfbX/65IvLKl2EpN1/ehGrFOnZiLKMexeMllglQORq4DYY6SQO
         RaU5wBOG5YfuTV4fz1M6Ax067ViN1bw7fJE06xNISICOVsUZ7bkuJRnArnFgeIK1TVep
         2NzfQwyciqod0Ud8mhWL9mTJAgyQOPLWK3uU58IMMCenLa5fFx0VSLT85NtS4F9pEsi3
         HvmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778417171; x=1779021971;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9UiYX3DX2mOcITjXbonrx4I6NoJQHM2UHkbJQh3OAx4=;
        b=A9N+oefWdfLdn1wRxG20LxXOfbGC2I8vFcDXr+0KkzhTq+FO3/JZ4w8YePYNEWrK/9
         bE0HY5kYEWHOZlwrpdyx6xBDS8feoXc8YMGejovZ1u3EzXoM+DwUiOUnELXrD2mTQ5RF
         UUZzvUbDNe37sMyKkDQ0/PMuubzr61dRK8bmIX/n3qm42LNGRGi548cgzXH0HGC6ogeN
         tCQ5uoHcHOT6Wjzea5RF92jQy8GX2grBxOAhJISIrYDWtfJff5kwgDYNHZ04b1uVa8yD
         3reCXrU5+HW7yes9MFR5ukKAku3oPiUk7xQtcFeY1qoYoNNb6FpOTHmDknPRj0ULlm93
         Luig==
X-Forwarded-Encrypted: i=1; AFNElJ+DaF6Alvf4x42qXFPA2IfJoJFTJu1tG9eUSfUGwiOTsuBO4z3tMnlUMZz75akZT9QdIbfBRrao/D+V6mFH@vger.kernel.org
X-Gm-Message-State: AOJu0YzwfUChdUmt9rfHDyBDDbzgdgUz8Igaww8LLmZiYLlblQFrAAec
	cfug9bT8bYKgz7bm61ps1Tya8m3pRq/XG4QYvxccMXlzct6O0DEP8t5N
X-Gm-Gg: Acq92OHD7RZb+MyzSWsDmRS8wHpUncJtGE2qamIO8BpNimFlL1vJPxLm20DVb6VxIva
	UbJq2ABQI17btyVz4HWz7VH7VkobkE+XK23IKvdMDSOspgRO5YgkT3gpJv0uZ6DAHCq2yhVcb7S
	78xEvuiSj6YxiTDFIJZOUwzeWd2cc4auE5k0p5w/RuxPSzIqsA+egFjyJKJHXCnrZWyinnVdq9o
	H/mamLfJH/6bPQnuJPVlin/pCqRKeRONc5rcQj8GxiJbs8BjfASIDigrtLCTU4YTVYyGvSAV9QP
	O/V1VbbFonIq+WGNxg5hv61jHvCV7aWHK0jfSzPjluLqpV6GIP33awkzWkIHGxQ2UD8CjoxB5Xa
	2ULHTFgY9zdV0Pj8IrpngCOOP8varEAvY81lctoOwj6C90cqDqkpKCwJPf3yO7Zn9iCwW4QjS9q
	nwjsY6HX9a3BbnFu0wYgPf2xKUnEVz4VQZwers5bUpQrJTYPrBXVz6UkN3SOo=
X-Received: by 2002:a5d:5f90:0:b0:43d:6787:9933 with SMTP id ffacd0b85a97d-4515b52450cmr33701387f8f.13.1778417170769;
        Sun, 10 May 2026 05:46:10 -0700 (PDT)
Received: from fedora ([94.119.44.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45491f8d4c3sm17943645f8f.34.2026.05.10.05.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 05:46:10 -0700 (PDT)
Date: Sun, 10 May 2026 13:46:08 +0100
From: Vishal Moola <vishal.moola@gmail.com>
To: fujunjie <fujunjie1@qq.com>
Cc: Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Haoran Zhu <zhr1502@sjtu.edu.cn>
Subject: Re: [PATCH v3 2/2] mm/filemap: do not count FAULT_FLAG_TRIED retries
 as mmap hits
Message-ID: <agB-ENpPdELp-7HA@fedora>
References: <tencent_AA501E9A238337BD167E5C2ACF948A1AF308@qq.com>
 <tencent_22E6B8849EC1141FE7773C64467E6F1E2C09@qq.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_22E6B8849EC1141FE7773C64467E6F1E2C09@qq.com>

On Tue, Apr 28, 2026 at 01:59:44AM +0000, fujunjie wrote:
> A fault that starts synchronous mmap readahead can return VM_FAULT_RETRY
> after dropping mmap_lock.  The retry may then map the folio brought in
> by that same miss.
> 
> Do not let this retry decrement mmap_miss.  The retry still maps the
> folio from the page cache; it just does not count as a useful mmap
> readahead hit.
> 
> Signed-off-by: fujunjie <fujunjie1@qq.com>
> ---

Reviewed-by: Vishal Moola <vishal.moola@gmail.com>
