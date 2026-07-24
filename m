Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9925846AA86
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 19:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784922393; cv=none; b=XM9MchmADt1D5Vwf6XMtLaO+M/sOH46/RGRGqkMoDvyT2j9x6Pe12Ol0bqk9pOSmkv/u0GOfEXbeAh5Hs6FbMB+Vpuz4MtawCqkZEZKX0juOK4IEQpKPIcklS4Y8AfvX6zHjBO5t5odFe2sr/0+xCDuZIjOBZwLgd3rPnMhn9WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784922393; c=relaxed/simple;
	bh=uRNIMzhbF4M9uJF2sBqdo8FKPZv1ilwUFjUqPSZPvZM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rqGsBe4daMTW40ZXF8dzLSGgDUlJlBzZW51wFZ9hHnUUgoB/p5U8OgFJ1LIAX/Wi9z6Bh7RD8DpZ8NQw12Lq+sMW1sTQwwOVN7vlonO5UbzRRFpauiDTQ/UNwrgDOCmjKNfVZRJxXmt2S+lMO27nGXaliK8uc/sj1jJQHV9stfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=WgrWRx/s; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="WgrWRx/s"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-80c5cb9a888so6229127b3.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 12:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1784922389; x=1785527189; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uRNIMzhbF4M9uJF2sBqdo8FKPZv1ilwUFjUqPSZPvZM=;
        b=WgrWRx/sdNc21Cx3KReY7KA+QgRgw3AJmqYE6Da9XZ75ho5BGDEhFpJyZwyXHPbFZd
         O6FGn3D/WLfo8HQsy261sUNGCkBrlau2z8C+7oHINFnzAKWjzR/y16BEVjG5J2GRcuKI
         Tpusx7EIoT3q4Uc/jEx5O4TosqH189l5W+dp0pfuuTiZidd5+8WuUDpbd5fGPH9UHFyg
         97q5ePh1l6SR6spM/KWmqqIuwcPy1SMBduK9Wm5NdcEsv4rUWr2cGL3MrbliGtPzmot+
         eJTVkMFuLUP8q/ochYPWakWTybsLKYFb2+MgFUxM8HyxysBJidHrj93B68j/eD/U2duQ
         a/CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784922389; x=1785527189;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uRNIMzhbF4M9uJF2sBqdo8FKPZv1ilwUFjUqPSZPvZM=;
        b=JPp7usJqYPZM5q2PKQBcBGCbZbralc7phX6QZC3NI/uEaYFYgGw0R1Q3gv35ezs4QF
         eueiPe4rnh0899jcwerGfMKpIYTixQnnrtiUyJMlMSaq/YaAX501MA/ZUlZuFgUBQr7q
         +7qJFlHRomRZ16iMG1YMs/mqBCSkcLJSBY/OvMn2MyCVMa0K0zxrp0GEnn3ZlHNUFCKI
         YylwbGCdovCoraS2mHZ7Akax4hX92EJaA/5sbklNvnXSSPdH+E45a/wbwassrIpV42Rs
         ITqDKoiz8JOm9+DC70kNPjxTINXCw1/RooqhlJuD3m/ltRreWT0+ZvKqNIejN6QQ8914
         Fgug==
X-Forwarded-Encrypted: i=1; AHgh+RrkfJpg1P/czE9UaqixWLTMCjIsl4N54LyBGZvBBhX5LEFjKVe2GWJ+vNyZOVyurqcaqUo8pTY8QYonk7og@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs9in0g9o2BM1aMHtjJR0QdMD2EhpZqyduiEw58bugeO9EkGoS
	7PsHFKGNyDGUzPO29tul8M1uswZaTejQX2RInkM9WHXlBoNi2YEdOjazfRtyABeQ7L+5ekb7T7Q
	GJ3FkvHs=
X-Gm-Gg: AR+sD12Xlv7Kg9AMvTOYUU0s7N14yvAE8hV/VfqXjZYQZmFz/5qyz4seoEncsQMHlK3
	QtCl4WiO3m1Cjrif4tAsIta4KfebGdFeeKX4IwLvT6REiMTEkVJjmbVl7XPxcfUkamaxF7MTgwg
	w0O7iQY/wYBzQfVOJ8ZmV2tzSkbNPoHdN4U2I0WV+N27zqgO3Yrc7YmnloPpxQ/1B2+i5KUpkHB
	IHe6Gq82vcicES1EJbHqw2RyxmH5x2bmoIcZUORLKc47+26/APV70NJ9mIERO1oKIQRmTZjxwKc
	8Lmsye6QjrcdOwooNuAd+tLIesqX/VArwgMRjtzpa6NVNz8D0ERY+E7mj+L9JSq4vkWaO9k3dt7
	WuZRmiNlzJY6bRYeGFq2Ur/pZCQBR6R3aA+5HL3a0apKmjjVNCn7Ince0fq5qzsFcAV3uK03AeL
	cIHk7vJyg8JFkRBAOBD44/twT/KvD7/WjGOd4I7NyKLbCsSCRbY6Olzf67VUNspLN0UCTqFL5+l
	UN/LkLOB+QxleEWuXCSEhphtqqo5Rb2DVApVnQ0LMODmcaUQiaREmGH9nrKLCvuFplEp2aC8Ndj
	Kjp6gA==
X-Received: by 2002:a05:690c:6f10:b0:81e:deab:43af with SMTP id 00721157ae682-81f4c144db0mr30221897b3.4.1784922388915;
        Fri, 24 Jul 2026 12:46:28 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:62ee:74f6:cfbb:28e0? ([2600:1700:6476:1430:62ee:74f6:cfbb:28e0])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f657d2c33sm4997847b3.21.2026.07.24.12.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 12:46:28 -0700 (PDT)
Message-ID: <4d8352f044ebe2ab49b1c8646718415863dd595f.camel@dubeyko.com>
Subject: Re: [PATCH 5/6] hfsplus: add iomap-based file_operations
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Christoph Hellwig <hch@lst.de>
Cc: glaubitz@physik.fu-berlin.de, frank.li@vivo.com, 
	linux-fsdevel@vger.kernel.org
Date: Fri, 24 Jul 2026 12:46:25 -0700
In-Reply-To: <20260724053311.GF4181@lst.de>
References: <20260722213759.1360225-1-slava@dubeyko.com>
	 <20260722213759.1360225-6-slava@dubeyko.com> <20260724053311.GF4181@lst.de>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-07-24 at 07:33 +0200, Christoph Hellwig wrote:
> On Wed, Jul 22, 2026 at 02:37:57PM -0700, Viacheslav Dubeyko wrote:
> > This patch adds fs/hfsplus/file.c with the goal of
> > moving the file related operations from fs/hfsplus/inode.c.
> > The hfsplus_file_open() and hfsplus_file_release() have
> > been moved without any modifications. The hfsplus_file_fsync()
> > no longer takes inode_lock() itself, because taking inode_lock()
> > here would deadlock against callers that invoke fsync while
> > already holding it (swapon()).
>=20
> Please split the pure move into a prep patch and then start modifying
> the coe in the new place.

Makes sense. Let me rework it.

Thanks,
Slava.
