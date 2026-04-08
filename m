Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861FF3254B0
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Apr 2026 08:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775636036; cv=pass; b=ZZA6qSYEDvXJIPF9ZrA9/8p1FIz5+lfRXsFOZMXe78c9NTzesRSGRifMkd5zzujydUYc5aMGjmO8LPXe8WCyLYmh+FefO8lw9HndEoXgCiD9h3KE8Y8PopPAfGpqyqNm+PUVBXpvU0JlqHpw63JZ3Lv7Bkl8TEiwV0HRj8jarWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775636036; c=relaxed/simple;
	bh=kJZCuCMi+6nh7iMBofmPX6zWmSuow3ewF9wrf9wR5oI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=iolQBy2EbrGANMNcufdMjTgL6LFpK3GYCTxirXQcaM668eYblEXrxwaledKkAmo50Ya8nGhbsYDTWtd+eDpGh8u0jNaLgHeT5Gg3thV1UdzjpTAZ2ZiBNnlyH3dEqNf6jdLCb/zx3zeLmq6sl/5883ElF7EcOg2rJAehtQD9rvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hSp4aJb6; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hSp4aJb6"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b9382e59c0eso951330566b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Apr 2026 01:13:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775636033; cv=none;
        d=google.com; s=arc-20240605;
        b=ldRF4g8XYBwhQumkh6tp5yDVkMvitkufC8DZVB3xHNENreXifDLEe7CaWE+8Lo9doP
         j5P4AHRtPc2x7pgMuqi+/XiFYr40ZUQDGguxVLPPpxvyNetLIowtOc6OJknNb4vxTYLw
         yKWp6gigvZsEkio0xX/J/ZvwttIrfyuI6TvOILyOTcly7sxZdYtHU/w5EI9TUOF4MpSQ
         ugcJbB949TWK5qFrzoGJo2TVmCCsk/23M7A8Q7Fi0szxDdyrqU/H2aGA3AGeARLI1Yr4
         4U5uZPwY3SRh0leMAwuTL6aNfUelfdqssyU+/TZJHC0uRdvjFiVaCv30hJUXXGViEDl9
         4mnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=kJZCuCMi+6nh7iMBofmPX6zWmSuow3ewF9wrf9wR5oI=;
        fh=hXmIyzd+A7hy1USumhuH1W+bmuI6B4mR2rYITz15eTw=;
        b=ZDtHvWz5bBeVZV+wZVYz1j3YD3FofU6xuvtt+U+GvI9N1u1LauX8PQkM+NS69NevMg
         e/+z5gqv8lyBU4DpMcdGxumXqUNGvnpwIXOfjWcWl3yKkf48uJR/hy2H5zMXnCZ1wIFg
         j1FkSU7MdF3yw3ocDhWdw0f0CZtv515qGWgr2aTRF8230p0sItxCLUYg6GjfDYZAb5Iu
         ds0qEPRcG09C/MlM2ClBnQNayA6+Hq/mSUY2GeIdPqecAdSZZL6sauGi6cRYVeR7FILh
         FGEpKGmcf97iZ2DtpjFRzo/dxirGq9TPWYwVY0SEWPWMeLa7VjD1wUkoApiq300J9mQT
         o9LA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775636033; x=1776240833; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kJZCuCMi+6nh7iMBofmPX6zWmSuow3ewF9wrf9wR5oI=;
        b=hSp4aJb6LRQ9/h3fjsGwb5ReQ97RKuMad+icBEVwtOkeTp2JAHcHX7eBowGlGm8nY9
         wxkNrp3sTWzXwElpF1FBBj+AxJZqye0gDJ8zT18AREDcZrJmeKPAGfHDus1BQkJ1bxvB
         HhMDIlGM5oDynUSmBPPCCEnbWbdZK07+jdlWEZBsn3QGyvC0geSi6SQDj/760gfuGxSG
         MrYsVvssXWQ5vFCUvm46y9ucdTrNzr/tFdUxIcyg3p1b4r7KO2hhqHCryCEtd92eWgG9
         1sxYt0sBbOI/dWhpntl08ByUGeyrizjjewQB/BQJpWy17awm49XVTpQUjzn0D1fykcYo
         7SWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775636033; x=1776240833;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kJZCuCMi+6nh7iMBofmPX6zWmSuow3ewF9wrf9wR5oI=;
        b=GMXYx3Oa0ZGYDkg7Bzzfj5VXSeV5YwAe82B7PgP8ZwgmMYcbykKAwbbSQ6iHgwdJlp
         KcuxN7znWHvuKtOGy29lEjqM7uO4RVvRAlECYSYvrtCaKqpszmUIF6mbYLLyf6ttplKk
         Ih7jw5R/Ix9PbMaQCFPlakXdi0aVgQY1lcW4bfvvfaQk5D6kgYGr1Ch50BAC/f6Ca6ET
         v5RatEenRk1W+DJ7vZYKujHF48lLnzXycHIr7ef2DO1owqOiy+4eWy68MWPS3gGZALgZ
         S3IHqM8fhel022LWnluYK+aXgcMDlK5R7Rvum68hN7VZ9VH0/gRjY+mP9f/JSjbwsM7L
         WNug==
X-Forwarded-Encrypted: i=1; AJvYcCWaP8uGh/dC85tWp5azZOhlrkgdybTHwP31ZEcdwps4tIWjPK6OsGkw57psHybBRxIkWc6/f36rU1F4nr+4@vger.kernel.org
X-Gm-Message-State: AOJu0YyrIlxnP4x36AVslF2VjXWwNDNZjm0VSaIoR0fz/XRvvN5ZWees
	tBu3GwNCrMcNwmET8klfyxjLEfmC6mpjU0zm8lXwB2z0wisqspiM1iKfBEmnA2WzVNZ2VfyEvqp
	KwBWGt4eL9lRtWfxCBsCS/LcuwJBam5w=
X-Gm-Gg: AeBDievLhYu+4UrlujwoMaha+xv5KpoYKpAX8r06nb3VTZKz7q0w1DG1lwU1okpe8nZ
	Fu6QiaF/9FPqVb5xROKv413z+YYXZuXLxP19vSijfufCvIqy4M756DEBXgmb5mn2jn5aNEiD3Yk
	+kFojeOVI7AhELps5OHnAmUdGMovQ3htmXRE/qoeo19LoCagWSRgT3kP6G1T8/+8UMv46G9y0Bv
	kLKNfmShyxsvbmhDkg9aTgFsc7HF+ZCqSCOZC57gD/nOBlwPFeD77dEACdAAV1ZLKHpE6bAurW6
	EgBaxsTUncr4TzUsAt/LSSNYpwOCJI1zl3lW8R5H0w==
X-Received: by 2002:a17:907:ea8:b0:b98:695:ec53 with SMTP id
 a640c23a62f3a-b9c676881bemr1024880266b.18.1775636032585; Wed, 08 Apr 2026
 01:13:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 8 Apr 2026 10:13:41 +0200
X-Gm-Features: AQROBzCuibnwwboJycojvg1oBg-6w64-Q5n7P-cfz7oa76mB1GsZzEHI6rAkrKc
Message-ID: <CAOQ4uxjRgQGxWYWbRbjVZy19oA5qKZSd9eANKyD8yCoBNGPNNw@mail.gmail.com>
Subject: fuse-devel list on kernel.org
To: helpdesk@kernel.org
Cc: Bernd Schubert <bernd@bsbernd.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	"Darrick J. Wong" <djwong@kernel.org>, Joanne Koong <joannelkoong@gmail.com>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

I am writing this email on behalf of the fuse maintainers and developers
following the discussion that we held on the topic [1].

In short, unlike other fs, fuse never got its own list and all fuse
patches are sent to
linux-fsdevel, which is a tad annoying.

The libfuse patches are sent either to fuse-devel@sourceforge, which
is a terrible list full of spam
or to the kernel's fsdevel list, both totally inadequate archives for
those patches.

FUSE is experiencing a renaissance of new features and protocol
enhancements [2] and that translates to a high pace of patches and
libfuse having to be synced with the kernel much more often than it used to be.

Please create the fuse-devel list on lists.linux.dev for the purpose of sending
kernel and libfuse patches.

libfuse maintainers will follow up with mbox migration from
sourceforge in the future
although there is no real urgency of doing that - we mainly want that
list as the single
point of archive/subscribe for all modern FUSE development.

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/adTyw4UJ04qOggCQ@amir-ThinkPad-T480/
[2] https://lore.kernel.org/linux-fsdevel/CAJfpegtzYdy3fGGO5E1MU8n+u1j8WVc2eCoOQD_1qq0UV92wRw@mail.gmail.com/
