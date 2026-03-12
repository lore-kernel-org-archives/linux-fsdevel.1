Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC933BB9E6
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Mar 2026 09:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773309408; cv=pass; b=fuK8HcY2AKrokaXwu7+pjv4cWwV0AudK6QylQ+05c6EHPXdbrOOqdH+w9hrJsNznwO2+xZHCBLPc/GMoLHb/EuywEW5NyQqTT4iaWdSiigEY0BOudS6REBEIjs+ke2YhBuQzl5t7dqliR/0VpFadQJ6qBmCyBI3UtlX6A4fqM90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773309408; c=relaxed/simple;
	bh=kATuWIVb+1sIwNqOxUhxUjIOPVfD08OcNfZXUQQsnRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AUU85lg5KZei1/KJNnmK97epzB+7CjvEAsHgfcMvP+WRwfHuL/Et7ibUG8WbMgqtLpRvzrxrMK1zQ8dx4C6gQjZE2sxLw3Xc+1pY4+IQZJgdkqMMn8yF4KJkf2RLVe0Akl/nraZh7jL2pboNP6gnze0x/SX9aFkNNcz54jJckQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eUQr2Irr; arc=pass smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eUQr2Irr"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-67baf20e8c2so245045eaf.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Mar 2026 02:56:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773309405; cv=none;
        d=google.com; s=arc-20240605;
        b=bvsHe/7cZu5aKBbLxy1Pwtn1npl4W8RHaytrZ5uPlKVWE1u4mFtw7XHpAKrdhDoY+J
         YoptnaE3++IbGOPzqCZU9obxEMpuxbLud226S4ZrBDFiCUDdZwkXgiO+P9HbT0pRlueu
         xFnvUlQt5uCMnPNd1HJ90CbALUJEU9AmN43I1xQRYW/xEhwYkvc2Rhbd9y+7x6e/bEY0
         fQoyq/ypdJ29Vrbvs9iAQDoFsWzZDXYrrwvLEm6jhYFPp7Sg/afPkyjZQaLzL5hdFCsg
         lSCWVCPntb2IxhREWaF0Kw0WqKWAL85AjKFSSWrQ7EnsHHN8GOYo3EgFfzCKGvdPytr8
         sZpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Cq9wFncXWF/REVrFnJf8evSIKW488/wgbuNtZKwBgAc=;
        fh=l7eN5hphNMU4H+9gp/Fop18IU3a0YWjcs61VETDGwtg=;
        b=S/3ijLvPEtf5ysHZ2+llyhxF8tFeJQq8agfNm0snfzoEqUJmrUm1JVOWlB0LsrWnD9
         fRpg2LSorRFClldxB5LmzKDIFMcZdI7AAfd8yKKn072i94ok6hY5GUtg/2apxsygvQRY
         NeD/pmgrqvSxsi/8uvGOHUkiWhHfrOEaSvb4guoygbFqDOkMmepnPccju9+cMzgVFPBd
         JB54ujAE/IDuQv+Q0Icgjd4wAEUcblZjQblWz17gkK3UAAwaBWdottpow9Gj9htkbPmj
         4bQdgKYFohgPQZ3N4opY8+0BpbOAa1rP+hgiorEiknuo54QLDvkujL1uoFfDqGmOZYHb
         6cow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773309405; x=1773914205; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Cq9wFncXWF/REVrFnJf8evSIKW488/wgbuNtZKwBgAc=;
        b=eUQr2IrrVwM2frLPnoyqWgZZuoXmkBLzuSImfd7TwZHm0/OhOsl7hINjg5KxdChRFd
         1bT4FJ7q2rE5WCiBlp2A+XZqZDxMP+snXIPW5MrAwqlSe5Wp+jD00FsJWGVeI5biR4c4
         DH7Jr/p1aiSYKlB0XbfApJQczqD8kvwHPNBHifmPB4CdY+sRZC+TzXoAvqfVenwRyMaH
         W9CCUOYdxzkHHjdGBWxHUNBTUcTi0Tis2osAuZkjMRYOmcif6aEdQEZrT4/rbZZCh9CN
         PUuI1Rns7vOdzgwMJ10L071jZtrFUVNW5Z1PK0kEmIey5bo1UlLMSnu64/jZ5ADSZMeX
         qeBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773309405; x=1773914205;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cq9wFncXWF/REVrFnJf8evSIKW488/wgbuNtZKwBgAc=;
        b=kcvgjyvuONLBihbE0cf9T0aJHYZFuRVpOujPwLA6LCTbPf1PVL8eTqZ4jB3SIVC7Wz
         cBhKXlgkvM2vWIZQDbbUExoqDhJ/8W4QO8dtXmSlSXmw4q/YFyGiEyquWJRe1Avq87Jg
         8Tp2IH3gPLv87cLugOOA1PIRQg2Ay5crkYRLUM/tpU/tp1iIMgNfk0kqMLZxUqmCfl+j
         eMyZraSbzaE/t9GPLJbbuEfrii1/m3uC58soRZCl/P4A7GOOPEJvQKZNiWAWsKU8aqXK
         Hiq52XAUWzSt0AQPDcnpavZ7pArrmRnb8DEt2XV3OQFrZMnnA4Alr1W5GVPp5eFP6HWt
         n25A==
X-Gm-Message-State: AOJu0YzEO/eP4RreMK1Sa9ZFkW5ej0phpM4EQB37Jw6dYXbkybQSXr4v
	z2LJz/WeJ83eEIT8rnfEUv6SjjZRnmpJ4wbc0jPaf9A2xmRPGEUQs+6ncAkMrQT6Ks4WyZKs0tV
	tDarwy8+3Z9iNQsEpnBomcjQ+/2lf6GG7
X-Gm-Gg: ATEYQzwjWZa6mI3tmlgzmdMLiLANELZch00czcYdOMqVxtm5ljfqIRY0ETD5CSg4j10
	rJ6lHysyIOsJVtMyqYI7e5vgMPf9h1KrltZa/L7oChGzZG8rZh3dFlUVZhWRAb1qxhlRhIaKZjg
	83Ksa4QdPfeZCznh4cfA+kgxFubQmd2kz1OBD0nSekcJYn0P2/citHLXUXLmvCI5vhWdr0u/q73
	UjdADN9afIBGDEmPgB2bet/Qb80czS6yHkfmtpfl6UYEh6TpdILNYURJ3eWTt+GtqLwR9/icpCD
	DTSwHA==
X-Received: by 2002:a05:6820:2203:b0:67b:bdc5:cc96 with SMTP id
 006d021491bc7-67bc88c4cfdmr3480148eaf.23.1773309405173; Thu, 12 Mar 2026
 02:56:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311215118.2891117-1-mszeredi@redhat.com> <20260311215118.2891117-4-mszeredi@redhat.com>
In-Reply-To: <20260311215118.2891117-4-mszeredi@redhat.com>
From: Stef Bon <stefbon@gmail.com>
Date: Thu, 12 Mar 2026 10:56:34 +0100
X-Gm-Features: AaiRm50Vsqpza_512soJb-Z4xmJyoQpIuHl_b2vtcYJoFYex-NYOFHLXWfOXciE
Message-ID: <CANXojczghYhVZgOpSs=Z6wDfVUBoLkEeFcooQiRWkVECX9j-GA@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] fuse: don't require /dev/fuse fd to be kept open
 during mount
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Bernd Schubert <bernd@bsbernd.com>
Content-Type: text/plain; charset="UTF-8"

Op wo 11 mrt 2026 om 22:51 schreef Miklos Szeredi <mszeredi@redhat.com>:
>
> With the new mount API the sequence of syscalls would be:
>
>         fs_fd = fsopen("fuse", 0);
>         snprintf(opt, sizeof(opt), "%i", devfd);

I'm not sure this is real code or just an example, but should the
fs_fd and devfd be the same?

S. Bon
