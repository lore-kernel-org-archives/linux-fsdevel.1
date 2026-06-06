Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DE47262B
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Jun 2026 02:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780714461; cv=pass; b=PYEKYtgpGUu25wJP76u7sIMy04WFdZQZkTn1fQPSez6l8ejvQnqrLgoD5Sck1yxxj+FRk2l/diWCQ/qH8A7f+uWyTVN4IGkOaoZ5Cm5bFmPU48f2LvRhVCHZh4FA1U8ykQn4xWTxZIHEd5nEK7rPRHrWUQhd26pWhbq5TMl/rGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780714461; c=relaxed/simple;
	bh=gyBlaQqg3VzrZkSMBBU75yndF85Zq8TKY1GV6tmlAxg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=QKc3Ky6QC5MT8wr3OXLF6DbA9CetTjTMM2copu6tSVZT/GbBxvYLxtKvuGOcU+TeNerXyZ04kWExCCQ0RJj7bSXTss14eIaRi6le+zyH8QdW4QoyYddrZPIQ469FLQkj0e+/4pGzydyjt9bgEFdNUayaFl3cdyNqq/dHZriH3Q0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dR0fMU4k; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dR0fMU4k"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-6603246b66dso2655198d50.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Jun 2026 19:54:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780714460; cv=none;
        d=google.com; s=arc-20240605;
        b=BK8OvwtiLxCbNVjmu65SqJlK81rUqH/PRR1HWwW+gKppC2uwLg1czDuMUHnXMEoa+S
         VR4bMRutjXYJMjSfNwPyMOf0J4Lw0zdpec8hKHZs3hSJV5NGT5vJxIh5X+LOL89qJAgC
         U/pV22fjYAEa6tKljv+7bQ3EGn8tojqF/U4w13NUyt77NlQvDn3SD7ajkqLbW6Bo5sEC
         j9IyR9W4QR+JcmXEUSckeguQMUnrajW/aTo1dAAXzX892BEhrHAqwklC7/8E5HoORXnj
         FnqGlsU3q8j6vvC9qgJfiV5DKz4EdCN+9ZYOyCJ/Q5aPMTMmf28FqapRxnGp069KD4pu
         3caA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=CERKcQSAU+PxO+z1pnoXKqRJLWekNtYhnEaObpqSDI8=;
        fh=BGqatSniZEbBAmcXJq98wZ2qdIjB0o1eWXfjm6NsQKM=;
        b=a8FvRfInCca60u4F07/z27gowhjOmiV4fLFYh5QDvj3TzAZt13R0gMvHFJBPfJ1sR/
         cmY7jAoZL/AC93f4l2krA4I8nXwdU5B1RAEcshgrSxmjzxFm15zbmuG7ZVr3A6SfvUtS
         Bb5h8NbBRLxy1hNAJdoUq08YPd/xH9CXckypGjtH3oxHR7YG+U4lCDDQuUJibh0Isdkp
         MMLDeRSEDJDNhrMtXFL1yLdvsNctxQyk2CUBdA+iUMkkojFiwf/LxIKcUvfbbIQ2O3c2
         e6oSdniTdFDrXa4y2MMF7rkW00hTXyUcgpqEsgXMLcH8maRB6P3iJr8qwsG3QnmxER2k
         I0Xw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780714460; x=1781319260; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CERKcQSAU+PxO+z1pnoXKqRJLWekNtYhnEaObpqSDI8=;
        b=dR0fMU4koUNxYsqVuXoKc8zS9FJRB2JB3ZU0sviZrQ3q5G/cyHurftPN53HXYBL61R
         brSwHtToQQNAftNPnX9E8TIF373/K0wfm9hIbIO7DUtU7ho69/dPAiScrkiCIoFHpKew
         TcYcYiFm4RrdrbgPT2mbWnUPs8YLeGpL2vLDqzGBDymH5M4C16LSdUxx8MSLV1qyKYgF
         MEZK6j/VYxJFsPZgNua8w8QgXZaFXJEulVo1RCbt9ahW71D2M/ji96i5ISki1k1Wh/Ok
         MTUPAJlJlGk37ZjgLSqxlHtSEv8zA7i8T5firjUDzSfBVxBIzrq2ShJooM95SM5lTV0L
         tvew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780714460; x=1781319260;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CERKcQSAU+PxO+z1pnoXKqRJLWekNtYhnEaObpqSDI8=;
        b=e9vOBTuNA487lO06CIq6gMF5+SW6UOv+t8l0oQwJqMQe+aa5QE0YqYxWXlsyFxAWhO
         7c2e/FZVLOv0DThnPP4lZ3HLTqxuISceoUBDYhOdoS9bj47SrmJkJSCxHKOY4iCvRohb
         zgzRm4xwUqAdutHwXcBYwSNE8UUvshcG4RkJCNZIBqmwYAxJRtq1YUCZjUgaKOu61PrV
         sEA3pKDUEqcCpvxr7T+1NH/FPNuitmDBrbxpD3yGxUCE0bkhRxxYtusE39YoDMm8//9x
         wvw+PjlBJaT14nPBmEa1ZEiCQkLIcB+A0HUOyogIB+qOGcML0+cLirZYvsnG7UJvw6vG
         nLLA==
X-Gm-Message-State: AOJu0YxJ/Cr+qxID041jpuNSau5183pqzFRCmEwgeKG4TCapeR2oGcAz
	g6cPmNSvNQMMlUR57lnyFl/UnYIrBhYRX9w/Ji1F/nSXrsxrDuo0IQjyvwRCeK9fASNwmgfCN2u
	sH26ne+cc0hJxnkhTI65DyY4XK2LINfY=
X-Gm-Gg: Acq92OEMEcFDtVtGzWbYa8lWWeAyRhYWXUo4pDorhoV3on+5kn/oFHJjMeyB1LH4rS9
	v6EEjafDt6Xh/db2Iqm1OrGp0nnQkrzRDbJhxLG2ISgUFDlt6f2+APENKQVA/J1SawOkhRaJh9a
	/H7XqMRRj25WYT1zwGRrfXck97duuIT6vPLqXHRFhLYJd1cOnq6oAYYtOiYoZld9MdXa+oFHg9o
	QL/GqUvhddDSIDbsxZ7xL3kMwmvkIsR3WiUlB0CL9OBZTqMoFD7AsSkonoQbS5bHcSLvWbdFM0D
	Jv8y2gQWEohfm+lqeQ==
X-Received: by 2002:a05:690e:d45:b0:65d:7d86:7758 with SMTP id
 956f58d0204a3-66106fd50cfmr5251767d50.59.1780714459713; Fri, 05 Jun 2026
 19:54:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Maxwell Doose <m32285159@gmail.com>
Date: Fri, 5 Jun 2026 21:52:19 -0500
X-Gm-Features: AVVi8CflXKtmmTxk3q8g73m0dVP6u2Nr1L6_iPh4Q-vGbxBQTCr8aMscEzO2AcU
Message-ID: <CAKqfh0HhN4zzV2=WJwC4ejRQup7Q3L6MkUegC9Bc0xFmzK+Msg@mail.gmail.com>
Subject: [RFC] Maintainership of the EFS filesystem
To: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, 
	Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"

Hi Christian, Al,

I recently sent a patch for the EFS filesystem [1]. While writing that
patch, which fixed code that was now incompatible with the latest GCC
(+ an undefined variable), I discovered that the EFS filesystem was
orphaned and without a maintainer. I inquired with Andrew Morton, the
person who merged my patch, about potentially taking over
maintainership for EFS. He noted that he was fine with it [2], and he
directed me to Christian regarding this possibility. As the subject
suggests, I'd like to take over maintainership of EFS, if it's fine
with you all.

-- 
best regards.
max

[1] https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/fs-efs-remove-unneeded-debug-prints.patch
[2] https://lore.kernel.org/mm-commits/20260605193524.f277071da69189161e84e327@linux-foundation.org/
