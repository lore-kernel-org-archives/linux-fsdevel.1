Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD3A364E86
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jan 2026 17:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769794480; cv=none; b=udHXBPbu7tWH00A230r/5fynLM/X+4qnU27Wz3gHHoQhca+7V/OLvDdl6aLxdEtUf80c6eUx4NvSR6XcVD7q2C0ojWl2j1Zlz//BxJ21HzPZSGr9sdUU2ooN+U+NAh6c5iBLugbFLm2XEp67y9ePUFTS31zpaTbrlWTsD8IgdkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769794480; c=relaxed/simple;
	bh=po7edBQiBk8FP/oPhiDSEZOovfiZ88dORRyTLqEoIfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UqsYBH/VQdjjsS/ANmykI24SYhBRBfXn6g3+x6FLwPVmacGNtHNHqoAkI8rt23AuXok0vT28UtVwCo50S11ihOyl/an+t3M+2sntcNZ70fR7NPFNDMbOkhRkwCJLzdxHQxD+U6gu+d3USSmAMD5zapJzMZ7JEYL83eClNHey0pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=L71RnFMu; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="L71RnFMu"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-5029aa94f28so19469251cf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jan 2026 09:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1769794477; x=1770399277; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lr0ACEC4r9sTM7XeNDuo4Q3LP3+bjrKF/ES76GEt9Qc=;
        b=L71RnFMuwoe3Ek0MuUPPS7wKLzWEorMVAxd8HctR0ufV82jVho936kBw/HmxtBPsgK
         zfrliDrL/2p+9/IbkhajqgNsKVtT7sxpyVtoXpL3vhg3/zYfPZn+b2zqPFqRFELkoodB
         ydZ9YVZxowejJKFWtG+eXCQ2/anE3L/4nGui6xzDX9EQ6DivwMBvXoyhIfoV8fDCB6tX
         NDxBjJe7pdJaznD9GmqP8LWLTwsg9b87bmcqZRZTyUntxQGfvgcChmQweY9IcwmySh/c
         7bXklbMWtxiXGKlEHmn6E+TYx9tODPoHjY+CqubKIxVMfXIGFk2I4FyYKc+zOaIKTaQi
         RSOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769794477; x=1770399277;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lr0ACEC4r9sTM7XeNDuo4Q3LP3+bjrKF/ES76GEt9Qc=;
        b=L9DWPgiNXolNV/143yU3iWkZkkCHFAJ9b72BOnlRM7LOh3ccbwOgLqusDeM0ZJGXLo
         UHarvhaXtcjMZiMwTiMvH97XwuwmpfH94xRShJn2zuF/eqi6vP+ujzT6MDryvgbwZSM0
         GhtL4P3ARSo0sW+YoOTEFe3JefwQp4cKbOSEt3cgQJOKymlr6izeXaEOhDzPHTkZNc/H
         fPUqHsBW5JtFL+gsvM23p0hvbr/GzOGmAksL90310ZFMNu4Ls1eTcHMXdW+Mb3Ie3+8Y
         bH/Nz3u1jEH6AIHOnxIZtahm74vobNKbJV+hAR2V8uLE2Tfv+gomikjA4MhBFfjvibKN
         tjqw==
X-Forwarded-Encrypted: i=1; AJvYcCWnBRwXugSqsmW4DrSe7zA7eRp+8SHsgEtBua+tTYlZo15Z+OxYGtO2lpxZaWHG53GCEepg06UVjWd81rIJ@vger.kernel.org
X-Gm-Message-State: AOJu0YyNQwa//Usw1QEdcYnJB/Ln/TQ8pzTuaQKcflSxno28OcLNmwuh
	WD+gGIea1rOX4hGuYDbBQCxsDa3R36uZ83IE90LkRFYHcmXOFhWyA4XpC5xRbUZaBqE=
X-Gm-Gg: AZuq6aKdj26NbjTYHDixdbDck7bJ5JFLI0+xrCD7gND32RKgyTVbLrC9Dq0Nm2DOPBB
	zELTD/YVWhrupvyxI4pH8Lh6ZsRNStdR0eYrs/I4C1JhU39faKZlU5WkyLMCmVg630Vt64+cMal
	YpI0cswOOe0yNE8CJTGIrLlNk6/8by9cEPC/xA6/qs7REwPmHsiCQbbaFVvVhUgfUoXaxquIR4h
	j6PecuYzeb2OpLKtcu+qUDTuY2MVRHbALfvP/u6NhUUBXgB+kwTzv4BHR7lOrhDJY6XKhtCiniu
	pWOWXNcPVv8hBVIfRwVsSxaQPIZYR1M8xloizYSRDF/s97FHOmYLhqvYHI5VHhOfgXON/+ILHiv
	vZcSBgqSQ52U8wJNMB50MDeAdH83erzvVsijfHKkomarEtRHD2S0/37jausI/koOti9jsc/I764
	xL1ccJxlUjz4Gc6Bi5wbKjBxGh4sa9heaEDh7nm5MF0jTmLT+yaOV3jVU8zlSemg9UxfeVQA==
X-Received: by 2002:a05:622a:20c:b0:502:a1c6:3487 with SMTP id d75a77b69052e-505d289da0emr31891651cf.1.1769794475777;
        Fri, 30 Jan 2026 09:34:35 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5033746eec5sm60844171cf.9.2026.01.30.09.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 09:34:35 -0800 (PST)
Date: Fri, 30 Jan 2026 12:34:33 -0500
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, kernel-team@meta.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com, willy@infradead.org,
	jack@suse.cz, terry.bowman@amd.com, john@jagalactic.com
Subject: Re: [PATCH 0/9] cxl: explicit DAX driver selection and hotplug
Message-ID: <aXzrqYOmgo15NZ7s@gourry-fedora-PF4VCD3F>
References: <20260129210442.3951412-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129210442.3951412-1-gourry@gourry.net>

On Thu, Jan 29, 2026 at 04:04:33PM -0500, Gregory Price wrote:
> Currently, CXL regions that create DAX devices have no mechanism to
> control select the hotplug online policy for kmem regions at region
> creation time. Users must either rely on a build-time default or
> manually configure each memory block after hotplug occurs.
> 

Looks like build regression on configs without hotplug

MMOP_ defines and mhp_get_default_online_type() undefined

Will let this version sit for a bit before spinning a v2

~Gregory
