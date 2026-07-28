Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A1613790B
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2026 03:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785207754; cv=none; b=enRVfng/iD7Bj/ADNTMwJHZM6HZ0DyOTnbLEesO0IlPXnweQfEW+aYZcFIBE1Ad/ZXwTEh8quHlaHoiHP5y9XOq4h9YPs9U66k+cf9ehML6i8ccCWTOWqlVZDb9FuF91H/vWM3bfJThDM+ePWKC7Q8I1jfo8npKzq3kS1G/1xQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785207754; c=relaxed/simple;
	bh=B6fnVXRqc2+KthV22TWtCiSs270dq/vI18HHPjC3FLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B7Hlawk/k9ICzmWaBHukY4FVsq9Lolj6X72FkE9auJkmYC8XrLN+3ZA13hIEa0pd27WUcGGzrNkIzKOsuCcQPI3iyiNme5VwlnNA6j8Rc/al3qYebc3DJMA1C5ut7ic/ZaqIimhnTsdpuoiLx5QqcUfTO8Ph/kmEvl9xBSIPj84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Z2W20BBv; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Z2W20BBv"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8ff5d1b0f91so21940416d6.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 20:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1785207752; x=1785812552; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BXSQdKo9ljS7GC2evl70cU/DxmVCFQ/8TIH5wWaTpfk=;
        b=Z2W20BBv+5MxbNYrTdv71jdlT/i3XotJR0L61+nfqR6hulQXs+Zhk+G8VbLC2Wa2de
         ZrXrMLBJcW3jwbSDaa3xZH/Bui2f4N80hq3nep1srlIv37cHBddGxZLHFRsigblGlkqv
         hPM+bMvfuRoqZdHkpE+lQ2t7qpx+MLZYh9mg7R7SIV9xX6UHdimTfZCuXGHXyyyN2Zh6
         QNN6jZFbzsj2013s1TDMdarXKhTXKlS+68NkVRpltkR7ua4B7Pe3MfbrVmghpKdl/Qa9
         DW7DMPoI/uYdg2RtGFQq9Kuvh5/nFcNt+rmhgtydy+gdPP7r0hiICJCek737VEXpmaeQ
         Jnyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785207752; x=1785812552;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BXSQdKo9ljS7GC2evl70cU/DxmVCFQ/8TIH5wWaTpfk=;
        b=qZSnkQwAv+vJCCqhgphUoVQ1k1f8iLvhf0bF6NhDHKO6tPlTJCQrSw7nIFwQHyTz2g
         EGdUih16tmsl3hCefHEV2BILcIMuEsZg713RSe7mC+hE1QCOsGyHbuWUnw7E5VVGt88I
         TUMtkP7kltgH8ZQ2LfG6Fz0H7mmpSWbkAqPUemJICHNQXg/326F64CC8+Duus6j/coFo
         j8qhgjZzmlBgsczdDN1eA63ITtGunUD2xyhSfu8/iI9qCMp2oJlvv7t3te386NUDN0HE
         BYNLdzmBLxjYZN9Qw32djybmCSwLDPE+lWluEuoguFau136KMDWBmSsbHfm6m4f8u+rr
         XpMA==
X-Forwarded-Encrypted: i=1; AHgh+Ro0yAuyZpZohmf7utvn8kA63jlNqJ7UhY25jFwoRmTs3kjXKmrHwrZjag+iAaOQBFL8PABpE4nouJvD7efC@vger.kernel.org
X-Gm-Message-State: AOJu0YzrY9SwTm3Tf66Y05WoilPkvbNauTswS7ZDphPr0lWFTYXLzPmo
	BNz4atvrvS/2iV871hU0BvmwumsNQUTSk0Jnt+6DFIClTdFQIuUYs9d7oDimZP6YX4s=
X-Gm-Gg: AR+sD10pWw5DHtw5sBBI6Jpg//xmc4qu11vhfpBryqCsP29rHY20CK7EMmRGVWEPa9E
	WSxuaL2RUKnUrPmlB0/DcswPdvZVaMqCEvEJydVDOe6MrfaiFCDLR73lQ0CV3b/Nbmz7UauV76f
	1TexSmJ0AzcBCaEqhksfXeUzS24Vk6KPyJXLn65mCEd3sfPO2d6N+CV+gz3c0vXpt4sxYCxYFyC
	wkL4wuhsc3bhKb54UX2NoVl1dXzVT7MOUk1HJJo2hCsH3fO0iZ2gp7IfCG4nIQzjl67hsQyWUFe
	Nl505vZtzRkN0XOQ/hnbzJtwqw+4VtOJDqMqyaDJCQeEIw4dRE9LuYitidonidZxupMcFulRTF7
	QkwbPEGfZL6/ljhO/ZJALgrdcODr+YF3dEQwq0afS6eol3CCqHIrkosklXA3pO2NR1NIeYplWWy
	PD3x5u3e53hVbqGPeSfUqgZLSMyddrb73Kv0NFwQlFZm7n1URFc9K5vmnFPg==
X-Received: by 2002:ad4:5f46:0:b0:8ba:3fc9:88ca with SMTP id 6a1803df08f44-908172f1128mr5966836d6.39.1785207752158;
        Mon, 27 Jul 2026 20:02:32 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907e851b717sm78500686d6.7.2026.07.27.20.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 20:02:31 -0700 (PDT)
Date: Mon, 27 Jul 2026 23:02:25 -0400
From: Gregory Price <gourry@gourry.net>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Jane Chu <jane.chu@oracle.com>, linux-mm@kvack.org, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, 
	Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, 
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <christian@brauner.io>, Jiaqi Yan <jiaqiyan@google.com>, 
	Usama Arif <usama.arif@linux.dev>
Subject: Re: [PATCH v6 03/12] hugetlb: Mark some function arguments as const
Message-ID: <amgbtoSMtlTDXgUs@gourry-fedora-PF4VCD3F>
References: <20260727181310.2671972-1-willy@infradead.org>
 <20260727181310.2671972-4-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727181310.2671972-4-willy@infradead.org>

On Mon, Jul 27, 2026 at 07:12:59PM +0100, Matthew Wilcox (Oracle) wrote:
> These functions do not modify their folio argument, so we can mark them
> as being const which will allow for some minor optimisations and let us
> mark other function arguments as being const in the future.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Acked-by: Usama Arif <usama.arif@linux.dev>

Reviewed-by: Gregory Price <gourry@gourry.net>
