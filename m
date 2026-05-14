Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E6E22068D
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 May 2026 13:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778765134; cv=pass; b=Wf5GTZzOvXQesf+LUnkBXMyBki5aON7YgLiU4ZJzM6gKD3BWz0N2R38K+LXbplBMt2Ykg5TIXdl2jrE3BQ/xb7sygToci5xzpRDEVv0JbTANNG7kr0rHHRjZBK4wvnDODDCeP8Of5keOqtD3iPW2q2Ajz741huulcmql9GTbXCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778765134; c=relaxed/simple;
	bh=q1KPWtlYGJ9k4GWdbOBFBQypFO+As21L/btu0m/ovvQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lvuXNRmWS6t884Y5jwtLJU5myDZx2MpZBcoCME7woXInIIgc12X0Q9grhfuxIDToNjD7O9DbltjTU5DCIMI+DX9iJOxcBMH8f2QmYHJk6HZq8yNBwoPAgiKRjVISukEHEc6WIoW2BfYD6vNBJzKCAq2IOsW3stybLFUS5m3kvvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mH0d6K6h; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mH0d6K6h"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-65c20ffb440so1179610d50.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 May 2026 06:25:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778765132; cv=none;
        d=google.com; s=arc-20240605;
        b=N1OgKqArDTa9TXz67G4tKHSW61nsyfqoTqjrmHIcEC2ETaJPuPI/GaD9jkklsnvKa3
         VTFWaluq/cnX3C6XwLas0a17xF3Rf6IeDXKUKw3ky08fOrRStp8ET/S156X604f2YSuz
         AEhlzQwJxCzgNsCysGHoVWTpYEDuHBeg06h/DmLD+XDn9LplLa87rC3k/bP6GxypRfcs
         /YDIkoD+Zv5q1eseFtIdXUaabur5A2hv4vDw6SMZfxPIbHUiT3zOtE72dbJgLtvqvaCl
         PFecjSpYlqsYlDmsb6TfxwhqFaod5eoTvuv/OaPVelzPvSy6FRuKHF+TH2Qz+L1FfbTB
         ec4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=yLvPZsnvIVyr8XYjbTjvb7MHno1Iwmok22i9NYEtxQA=;
        fh=zNbUK09E7fx+U2f9h64RC0tWsQm4uNM1cvCtYkp56xU=;
        b=b1E3wL9gUbk/jLgJtRl9Mt3CH7poNd5+NwhEcgU+kc6k0E6xd8jyDXp02u5evG3iFw
         OPlOKSBpL+jhEU+ok4KoZTzW6u5QxJz2tfBn/saBXhuCewPVhKEJSXEUWrqg2MIrIQum
         99svIKNsX8LS7rdwmAW4MiUKsCaSlD5DST/reeNwaS6gnwlil8k3ZV9fbMiH0HZiu2P2
         Jgt9PReS3jDussG6oGMb0dZDfRe4aE9O50009HWt9fGSc2o2JhIZTXV9OptGKkItOB0W
         pLuUVtUdmmUVjJQqxREVxsgt5ig5pVEGxzfnZgFNd6MZi1GwSzpcIwK1QdBBkNK/5AHM
         sQqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778765132; x=1779369932; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yLvPZsnvIVyr8XYjbTjvb7MHno1Iwmok22i9NYEtxQA=;
        b=mH0d6K6hNRXbpaOcS5ci+N9EL6c1qrUhxCJ38F2Yj1+g6JgACs+bmNYw+ncsYNuYkK
         MIszaU/1HbJk942lEwFTrtVVrk+DMdWd/8dWh38+lMMNLC4T1DWc3eiNKg2U+aCeYT/m
         C8pb16rOstL5yj2cvUoTd46A6+v2dKBfEUBkNbyoLtXZKU/x/HyXXjWtDSwEXrJmCgOf
         x0kd61YlzgUOHdpbNIT70RIXsGIS2z73LZsnBNmd7/qGHPPQxFfmMhhz1AzRd2hGLCtr
         kTCMiaU8DhzQnVIYwLjV2JgHlmO9D5IJxn4WGe9WZJnHrpADJSiyvvvrzap3EsRr1oRk
         XcjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778765132; x=1779369932;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yLvPZsnvIVyr8XYjbTjvb7MHno1Iwmok22i9NYEtxQA=;
        b=oJ//wW5PPKT+1mRk5o+85Wu9Tgp/ITR0U/HRyOOscdX5WCRRt3TotpPJ8KUNudS7bf
         f6Lpqx9N+4Fm4y+630UA8kwemdF5PJ7HGdYcDIi/lzoBwCAqxG7Tm/7JwyITe8fqXDpT
         2Zx50pSx23JFqOpY+P+x+WTR+rvdzrrxS0TvblBMX6EVaqcOnMamqc2xmWoTt7Wd/ofe
         y1YG7dMrPUZu5qxfR6S8a+XIB+lWgJnqXMGIbTd+SdNSCiozEfnB9KiP/xXutxWQR1Rs
         8aGuU7oOVBwwBclRd6NKyyEc4xcs2f0HfW8l/+5W6yHEVDsY1P9txrrxkUy1x8/X2fuo
         xZjQ==
X-Forwarded-Encrypted: i=1; AFNElJ/tRKZ5MJ36bWa085vCrNskH4++uJM/665KSGMIlGBSDR55YOnMoXD8HBZBXmwJtsEHEGPBDIYu5S9gIWmE@vger.kernel.org
X-Gm-Message-State: AOJu0YyzMD1JNVpvB0Yh04GES/A4rRReLNYRC9Sx+LIU81kypxKvvnFQ
	mP172bAc3b0kuWwtZk1tI4dkto+XCX6cJIkHCPMyi4+AZWwbsRS9Qvoc1oWur3c1wbs2plUGfK2
	gdvQ+Zeiq4mBAkU8Qt8kl+3I4kRAymZE=
X-Gm-Gg: Acq92OGL4Wb2XBp2HenW3imHe3FPzCeuPD8eXfvfNz4Vc8Muy0O3DZb+U/6wer/m3xy
	yBAO0igBZnRawS6qW+Hpid/bND+p6zjqxXYo2q+iJIoFjma2EsuCREi0IdbiymUOgJfb4nH39f2
	00gLrjQw9lEO8gqUEHKGUIB4U1kqW6v1bMJrSr5ZaDnSg5j9APdH0k886lcmBYL6dVAL8zVcJ3L
	bUImIiRAhN3hw72d4uch9ZIjEkvs7IFYdh6ibVS2KWhLaqI27ImxgM5OyJNVUDpaXhOy8Xqarpj
	Hcw14J86
X-Received: by 2002:a05:690e:4411:b0:651:d0a5:ce9 with SMTP id
 956f58d0204a3-65df6381d9bmr3194269d50.6.1778765131957; Thu, 14 May 2026
 06:25:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511160626.1268612-1-charsyam@gmail.com> <20260511160626.1268612-4-charsyam@gmail.com>
 <CANFS6baeNEftv9Zwn7_tNxhH2B8kEhrWOT14RLyewr1_rhnrsw@mail.gmail.com>
In-Reply-To: <CANFS6baeNEftv9Zwn7_tNxhH2B8kEhrWOT14RLyewr1_rhnrsw@mail.gmail.com>
From: CharSyam <charsyam@gmail.com>
Date: Thu, 14 May 2026 22:25:21 +0900
X-Gm-Features: AVHnY4I_B9-D6p52U-Oqx-i-X1_Ut1W7YC8VjOZ4ni6kIlVfLr4QhWBWmNcD5P4
Message-ID: <CAMrLSE6ZwKd4cS0YnXuKRvYoRMfXTKz8_LH62uD7F-vVR1kGtg@mail.gmail.com>
Subject: Re: [PATCH 3/3] ntfs: mark quotas out of date on initial rw mount
To: Hyunchul Lee <hyc.lee@gmail.com>
Cc: linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

    Thanks for the review.

    You're right that the driver does not maintain quota accounting: it
    creates v1.2 $STANDARD_INFORMATION for new inodes, and it does not update
    the v3 quota fields or $Quota usage accounting.

    Given that I do not have modern Windows validation for the exact quota
    rescan behavior, I'll drop 3/3 from v3 and resend just 1/3 and 2/3.

    Thanks,
    DaeMyung
