Received: from mail-pj2-f11.google.com (mail-pj2-f11.google.com [74.125.227.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0907335957
	for <linux-fsdevel@vger.kernel.org>; Sun, 27 Sep 2026 20:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790541031; cv=none; b=dA1A9KEETIsj81rEfacjd9AIDkABWZL90Cle1XvFTnpjZDN6rVHZaql3qAMldMqfaDX7Z2EW7neg11x3xa+kCfAfIqQSa8Xg89GojOSOKagzi998aBdZK6RD6y2sRLF9vkCoc4AArgBsTRm99OUmIda5eIC9si6QvDDoaulRakI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790541031; c=relaxed/simple;
	bh=o6cflNN+5uNq6lgPY1cP17X/raP7e0k7d2gKzGJf18I=;
	h=Message-ID:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DeFC6bS93UQyGLKOVs/IKtpRpIaT4x8ney02VZmXG0vOdVVjAj1RL2f3YccM+i8E9wEP2c6bMQCFkPebRyFl66y5GoUnT1JLsvanEPFI1TZLED8ZFnbJvmi7YyZ6xomR/ckHZQETZBozC98NZge+OBsljud0K4tc23NS4E5sRHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b9ucReUc; arc=none smtp.client-ip=74.125.227.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9ucReUc"
Received: by mail-pj2-f11.google.com with SMTP id 98e67ed59e1d1-398a384b5f7so585378a91.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 27 Sep 2026 13:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790541029; x=1791145829; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:subject:cc:to:from:date:message-id:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=o6cflNN+5uNq6lgPY1cP17X/raP7e0k7d2gKzGJf18I=;
        b=b9ucReUcDIya6bQw6V4oVEg6bRPhSeLInafTUD7xwvhYYNxmzhKY/nzih7TQDWiBPZ
         kODrJyOqsTFD7iPi/YfhUX1Yky1T5x/Sy/b8d6af8m63SRL3m5zEv+h88vVrUh86tUXS
         vevQ+RpBJyG10dHKoHBdHnOhGeXXMDAjfx5qR/vCL5WednhhiFlIZ2IjgHPSgScTAn1+
         /vqU5X+NBppFws+YNHotHhchtCqIzM6IFwsA8o6a5LE2YVdhCXCKo55lwjAYBiXimBbC
         iEZLZ7GHg37INfdr2qAnh80eKDGItcLSjL4C/1iuRaTEK+KR4InI/MRY0sm5xRLDDgze
         I+Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790541029; x=1791145829;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:subject:cc:to:from:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o6cflNN+5uNq6lgPY1cP17X/raP7e0k7d2gKzGJf18I=;
        b=pqfaJE+eyxstqT1wY9SwqEmfMNCyRGOi1pDJ9dedxsyfxbyF42t8ii/0ogDjpiVyQA
         KY63QONdqcpMoly650m66ZoiGz6wz53J+4Vx3Puc6JJwp7N+dEMX0aZsKY5F9C438xV2
         336dvEYv7NpduO962TJNLHampJ2X+xZasbkoFyTZ0hjVhu5+7shPpycKn5jZI0AIz57y
         7sPiygtTqfmSfFZwac8cjW+37owgHdVLDpzlULnWNVhgvKeJ5ShH3jqruMwuIayc8mrN
         yB9Xsq/BGo3Z5sAuE4JBG3fOdZhToOZiaBU/Rg0jkl9mkCN98z5DW50CKP10s1TjDqnC
         OaBA==
X-Forwarded-Encrypted: i=1; AKwUvBxX3ut9IxNVJNClIOVPi6VXgL+A946ITzJ7KRQIua9yFz0FmLXhtIDMeGa90Ex/v7rIeTj3E0hXAk9Rwn9j@vger.kernel.org
X-Gm-Message-State: AFq9FYJszZJs7ucYxt8BWT9rBGvvN0oVcXSwETHJ4PBwV2yna9nBTlcf
	AbwckySrQ2lRjFEqQ1V1r7m8GkB2jbnjtBsmzeQ1NJpzSUaCBw0ENw9D
X-Gm-Gg: AYBFou2ZD8f5QkX3xRtphQUcEQzy0Ri0cGXgcjFh0d/iM7z+/IylXSkv4CH2IwJb6ms
	j8oREyq9MnjceT01X2L4hg4YGqQ4WDyP4Tgmh9HWzV3qu/diehwh092KWUo16llM0rAKWR4tmRG
	TZhnALEGTeaibJ4NY29/cqCJ2v8pPUGw7epRObG1S4unXKcSFoKho5RWJPfqbkV2muog6SMSHRx
	a/v2AX6oUOUtcR0vABIdBr73xXPVDzlkDtde6MEUtL+WBmTwbN2eUhmz3xWCOzlqbhisQqKz5jW
	hbDB9Ojx/Abo85bl82rYZjaH77BwzY5D9feos7LqoORfP+fqGZdPGr7wcyopLbrS2utGQ+apPMd
	o0INXbfBo1nMCtj05PCmd1eyCeUHDRG4N7YGemtzLFojq0I3AoThkkIsUwFWeKwqYJa7Dv7cJBQ
	WBKkwscEw0wLeJD+t4vHlWDR5IwzlWZC+uQPQMAEksXbl8Zg==
X-Received: by 2002:a17:90b:384b:b0:3a0:c360:a562 with SMTP id 98e67ed59e1d1-3a0c360bd58mr5153407a91.14.1790541029308;
        Sun, 27 Sep 2026 13:30:29 -0700 (PDT)
Received: from [127.0.1.1] ([2401:1fe0:5::3b7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b898cabesm16824473a91.0.2026.09.27.13.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 13:30:28 -0700 (PDT)
Message-ID: <6ab97ce4.a24da115.4bfe6.0f74@mx.google.com>
Date: Sun, 27 Sep 2026 13:30:28 -0700 (PDT)
From: Zhenyan Wang <maximwang110@gmail.com>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: Christian Brauner <brauner@kernel.org>, ntfs3@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Zhenyan Wang <maximwang110@gmail.com>
Subject: Re: [PATCH 0/2] fs/ntfs3: fixes for directory permission and symlink
 consistency
In-Reply-To: <20260927180359.3867508-1-maximwang110@gmail.com>
References: <20260927180359.3867508-1-maximwang110@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

After analysis, I found that Patch 2 introduces a regression. The
readlink function treats backslashes in symlinks as literal characters
but they're path separators on Windows so symlinks created under
Windows cannot be traversed.

There is a partial way to fix. Since symlinks created under Windows
wouldn't contain '/', in the readlink function, we may only convert
symlinks without '/' to cover all Windows-created symlinks while
keeping some of Linux-created symlinks shaped like 'a\b/c' unchanged.
But the 'a\b' problem is back again - it isn't fixed because we cannot
distinguish it from Windows-created ones.

So I'm dropping Patch 2/2. Patch 1/2 is unaffected.
