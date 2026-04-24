Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D22B36D500
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 13:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777037161; cv=none; b=P5kxT4UHmIV7df7/g9zoXmMTM9W2uj65typP896EoepFO2ajzzgI0qXh3cY2Nhgmn5bkylJH5hFXZfuatLAI+vQXF/LwYqaUOwpA5+kq0pgOghXIRhNED6lkBGukuEvW4nNtIJ6VhovJZvbNkUlba2reKyt2cmvnXtjNiL5ldJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777037161; c=relaxed/simple;
	bh=AwARQ4HT7CzsrHCJ4iHvttcyWJy5GfGt9dkoJ/GPL6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TZeBmPy2ITxp4Ud/2U46VD+aQ6rcd7GHd7zkhRYrZyUvl0i84N7NTFATk5aIceJCnXTgiYtAvUk/hPxY4XLp7nUgSka30nQl3KbccBd+XxxbNfJpp9xq320dk3QD5jU6V4sgbqkwQhFg27WmvY/tFJ6EScEqHd3ig/ACXKjfutg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oaOU0vbZ; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oaOU0vbZ"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5a402dea4a5so8277395e87.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 06:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777037158; x=1777641958; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ff0pvFENIRBXsx36gJRS/Pi3Sb7+mMJWoywzMmXc4yA=;
        b=oaOU0vbZOUTZkXOYvxNZdqfvqP72DWpjlr4ubCZMPegrTQRQAUQlJoQ0gTAKnDrL3q
         4pZTSdHioXGDLdjLae6WvMYd5gvWaPDAfqOcO0ITuWwtrV+YuNbMj0kxNpLsajwQuoMu
         oBpqBXE4FgU9z3oqoHPezIMDbdATSf0Xxwb96luLiGkat6lWieZ7WSbPumgGthqC89J+
         m/7vw+DAFAM25ga4qm7cK+1D07XIAf8M4XPdw+PVHpL2MBReyUYA8rc2U5RO8pW2SXzD
         9jKjGmGbYUDmeRjvfhOh1yLrwiD5I9xw/y2svJSlDFEayDkz4za0o64Odl7MB8zA1iKK
         PrEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777037158; x=1777641958;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ff0pvFENIRBXsx36gJRS/Pi3Sb7+mMJWoywzMmXc4yA=;
        b=J56NaP4i1zgAOE6/UfzmTQ2bsmF/ljnVPFrLSBwFhAeVrfR0eiwSc2BMKs1T1zkjg3
         hK7A5l+ZJjh6fHtU0UPO+P8vN6qK3H3wqmUA2Afj+kGnMJVv5OQhLV+4SUKlcQa/xRUr
         03whLqVCvO6QOJBL/xYwNx3A1yEpueN5Ib1dMY4+rJOJVNV1krlV3wMRA3+hbS9P279o
         F8RvKoUkx5LFiaRIRtF39BXLrVKye//KxnVr3Rl8Dpa0s9X1TASTqfs2xYREJfIX7986
         VsbzawVHPM9vzNaqeXrVyfEjHwBy9uACs/ZEOK3ztsNqw3ZW++1rmKYlJkNMQRypKFP7
         NZ/g==
X-Forwarded-Encrypted: i=1; AFNElJ8kOZjiqpUs66R9/1ZWjOoClrh3p1ICTOyLm6QREiDGwOnGQqWxQjSZru1D1THnCGK3M3LH17lKupItrAkQ@vger.kernel.org
X-Gm-Message-State: AOJu0YyEKipnsOV1nGuS4KOgscHfkvZm/4DRD1H5xpNRJm0JBsaNCnPO
	MENv4b5DrgXWoKCygquJDaG0HPxNWk3Hha48RyJWwfGkjE9ZVUWdbWA=
X-Gm-Gg: AeBDievHBdr9q1XWQ5rlRO6ylr7Pk3yMQIptrsZeTvoyZhS5l7ShsSwAyaU1Z9tCkOU
	/9KSBre3V/W+xqT6FMwjfSR2cwFhEjW9d44N065eAfB+rRIQPEPSmNDmJlUWgThCgvjRwtZyGln
	ZgoE2eoMRUVMWeb5URYDM1SwatV+2yKyq5mRvyLjjVRWd1txWNNqz3duE9tIzm1XcChlFAZ8PaV
	dZv2g6ZpBq4G5H0+hKiS3D41RkcNAu39RW3gFAywqeaKITgA9qErcw7Av+9F06S6h0zXmhLYlRP
	Zgro/T2iKzBrIFuXGRSBGvpr3llM8Srd9temWeixySzRghum/uQ8FJ7RkWhpK4UjtuSXIrGhnJV
	wD+lN67hbjbNo9i8093sbG46NHNa/VZdQymH6ohgV+hfR+YTMkXf5mM32e0gJAXlmKNJ5EjcIVy
	mWjrOptPNS26iFaYHktBQFYQQ=
X-Received: by 2002:a05:6512:3f0b:b0:5a1:1496:922 with SMTP id 2adb3069b0e04-5a4172eecccmr10206146e87.33.1777037157964;
        Fri, 24 Apr 2026 06:25:57 -0700 (PDT)
Received: from p183 ([178.172.147.205])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a4187e12e0sm5990946e87.51.2026.04.24.06.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 06:25:57 -0700 (PDT)
Date: Fri, 24 Apr 2026 16:28:08 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Shengzhuo Wei <me@cherr.cc>, John Stultz <johnstul@us.ibm.com>,
	Yao Zi <me@ziyao.cc>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] proc: fix comm_write return value when truncated or error
Message-ID: <3f91ed95-b38e-4049-b69c-13335b13ae44@p183>
References: <20260424-fix_proc_write_return-v1-1-7a793c2aad32@cherr.cc>
 <20260424035028.a811dd6bc8248b640a9fd7c2@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260424035028.a811dd6bc8248b640a9fd7c2@linux-foundation.org>

On Fri, Apr 24, 2026 at 03:50:28AM -0700, Andrew Morton wrote:
> On Fri, 24 Apr 2026 04:06:21 +0800 "Shengzhuo Wei" <me@cherr.cc> wrote:
> 
> > When count exceeds TASK_COMM_LEN-1, comm_write() copies at most
> > TASK_COMM_LEN-1 bytes but returns the original count. This violates
> > write(2) semantics, which require returning the number of bytes
> > actually written.
> > 
> > The count parameter is size_t and should not be repurposed to carry a
> > negative error code on the same_thread_group() failure path.
> > 
> > Introduce a local len for the truncated length and a separate ssize_t
> > ret for the return value.
> 
> Looks right to me.

> > Fixes: 4614a696bd1c ("procfs: allow threads to rename siblings via /proc/pid/tasks/tid/comm")
> 
> December 2009.
> 
> Hopefully no userspace is depending on the broken return value of a
> write to /proc/pid/comm.
> 
> Arguably we should leave the code as-is and add an apologetic comment
> explaining the situation.

Yes, this issue must all over virtual filesystems.

Patch may break stuff in the other direction too:

if process is doing "full write" loop, and write hook gets string
which is too long, then the last piece will be written, not truncated
first part.

	/proc/alexey
