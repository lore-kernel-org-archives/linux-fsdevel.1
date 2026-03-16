Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B1A36A000
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2026 21:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773698383; cv=pass; b=aJd9cZNPk6C/TMEpk9manGL1DzbTbbsgQj9UsXu1NJqGawoNOmkaefBkZ0R/uaBn1Wk8fBRntU/0hxKRlNdAT8PUQovCsdP47DnGS6IHe3zK8f/oO777kpHh2VGIeJBGRqG5CJVPbdIIx7Zc0l60vwOnNFRyFdm8rrd+ASjSovU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773698383; c=relaxed/simple;
	bh=9QvEw0u3gRMsyoZyk+ByF8/LpMUDYgdZiDWMnaQ2/XI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QsRJ/70fcTmYN3OECGEQ0s5ED463NoEAPzlTZUQnARuAYZby3d08j47D5yJuD1Jm1t0wDHF27XhOwBklc0dMrDWLPW2MZUxdOOy09sXzS0fo9N/5MTKlmUiHZwA1/8p5csrvsFLaf7CY7KtiiHS3n2XidrWQ/JWjM8cfmU+vMP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=HU2mPT0z; arc=pass smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="HU2mPT0z"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-35a07c4b17dso2139597a91.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2026 14:59:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773698380; cv=none;
        d=google.com; s=arc-20240605;
        b=YimrBdke60euCkar1R9jpkzQuy8EEFvuFC7pWKMwkTianfeM0yaVgpDA38A6zkhEE+
         c3K964qci4UrGw/ITOftz7oCAFBK/lzsHnaICqN/ZZmpRWM4SnJSjDRsOm7A0mHIFBGU
         PAY7KQPlTKopqrYzIeLL+Cb60nD42nHhruiriVeF+eB8YLfb9yxBjTTVjakg+jxA9fwW
         9HN8rvs/natIwnXGSq1VvsQStKFv9AeaReoFR96QgnLLJsCrAqnskf6eedmms3TAS2FA
         Wea/mk/kidqRMNZg0vSMGYQu5iU/tpUNHtLqmlizhDmswXg785nDbWmktQNkVV/3f5nT
         knPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=baaz05vN46ySUjc5nMXVfWNyK0uut6ez46xl4bwWy/4=;
        fh=JddxvkNcnYLfEwCxPJ2s4Jg4PGeAAyzZjzOpKTIca/o=;
        b=YBkrONzEpIK12pYgXfGiJqAkf5c48q3NDO1hYWeEs9tVTXuimoa4wac0CA5LPAYAGG
         XPrF3ZYOYHg9J0E5H/BxIfe/Di94GHMh5CSsqWG07tyxKnmUuKmmnv5GLvyOKRE6thrp
         WPqEa8d8t1RSXV0M8Y87DglVjN1nrt3apQ+28j+ZpMq8aSeOhHrHywHnHkZgq4R0lgAL
         Mmll1JpNbFEa5RHV5vuCa4cO00awFsynPOvehNrWWOay9VeA5rLXAAQzDHl7A7544zuM
         QUrGbCSON4bjKt+0GJUgqOQPKRze8m5CRlA8ZqTPDXUnG9WTvnIsi47Q6/I7vnOYMteW
         zTEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1773698380; x=1774303180; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=baaz05vN46ySUjc5nMXVfWNyK0uut6ez46xl4bwWy/4=;
        b=HU2mPT0zGfye+/qt/BFyxrPvSX5E+ihjGJ8Y4InhP0ZJvO9/oqaVYHe81A8EqMLY9n
         xU2NJ5CFZsOcC4CCvwcMIJe64nzNIJ3kfF0ugjwfI7/ilGdmaz1O81K2ca83xOXNx4pG
         u5shmfWd07pd/6yNfyIehLkq30Hge3Wg9NaaQq9/nvH6FqwwR2qeJWI0JQn/EaJCjLXs
         DGiDBStBpweklzGz0rVRg05tkC3XSxE/ardUCgHyB+UYg/TK7zsISfRzOaa51T/Pcotc
         FUvPsuHniOQUOd21OTKKY4quYDE2SsUUG/cmse1HPkElVXGLqb6iVgnOyGsjlncONey7
         qQcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773698380; x=1774303180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=baaz05vN46ySUjc5nMXVfWNyK0uut6ez46xl4bwWy/4=;
        b=kvnI/tWF7Suypzv7gr7R8aouEAGZHoIVkZDnVG7lvykqkpvsEbMK2Zus2cSV+zgXMe
         0kovkB5LwJn6bOtfqyROZonA375E1flEBj4LHrdhyBfr1c6FVwpCTVwnKNnYi6NCUZ/+
         9TxZrUsDus1/6t9KA6OFWLyxnGWhuK7Z0cx/r22LHBDAcfqp387p2U6QlF2vrmsTbA5T
         Oe/7XmHqypMyxqwPft2TWNEVT2Q09J87Crjmc6tj65G9L/O4IMO5DOLj4KKuFHzbAE6l
         KLGSt2z5yuB852FkOMR2dzmi/5dA5dM31FVJsMhqGYKp4QkVZjJAQAGKOpIkgohLK6+e
         v19Q==
X-Forwarded-Encrypted: i=1; AJvYcCW517rHm77gNdRq+8e6kf3Je2kO61F5WKW4dNXTEhPV5RhRgZH7maCEBtcRtTE2MSmQeHnaBgiCucRFD6hQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxCp0g0Yii7Xl390odQ/wddx0eJUWNq82zoAyUnaJ7GqeGt7uT7
	slnIl8DuJErJSOCWqBXoxATXJLeOQrUR2DP4RxjW5B754EQ5CumcxlwaTn3Ol/iYQgnHgwRS6J4
	mj330G3fcBz5LudA73+qL6EpEtnMeUsboPMRo9Ter
X-Gm-Gg: ATEYQzxoTcZ96JOpGvDEJnaP0e4AKFFyTpJhbybHPhL1ayx6E7xrKWiITc1UFhXDwo8
	OqMjJjFMHGy4kAQtI5BGsaFXaR5U1d9sN6EvTMyBVkhkOaSH9GQTOpkXx0eQZJwzk7dWyqWFQeD
	myvndCuJ7hWzf+mgD5cirneDmNEDUgdC3esIbZiSBIbVFByKy03kKnYORYqAiHHA6ldLqEj7aeI
	S5e42JiyfaRF2mE/OqEScZeOkY02qI7DsvMcrXmgRPL7849642YIyTPjk80e3f/2Cmj4+toE0tE
	n3Xj4N0=
X-Received: by 2002:a17:90a:d60c:b0:34a:9d9a:3f67 with SMTP id
 98e67ed59e1d1-35a22081eb3mr12428760a91.33.1773698380402; Mon, 16 Mar 2026
 14:59:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316213606.374109-5-paul@paul-moore.com>
In-Reply-To: <20260316213606.374109-5-paul@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 16 Mar 2026 17:59:28 -0400
X-Gm-Features: AaiRm50Q0DM9xRE6xrYOCEeiOu8cKoO8ieFIUmC4mYeVLGbPolGQ90N17nL41QA
Message-ID: <CAHC9VhTEX-sRjyVi2p9j_jFjyWbzy54b=iteiTKGq-mnBaHkrg@mail.gmail.com>
Subject: Re: [PATCH 0/3] Fix incorrect overlayfs mmap() and mprotect() LSM
 access controls
To: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org
Cc: Amir Goldstein <amir73il@gmail.com>, Gao Xiang <xiang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 5:36=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> The existing mmap() and mprotect() LSM access control points for the
> overlayfs filesystem are incomplete in that they do not cover both the
> user and backing files.  This patchset corrects this through the addition
> of a new backing file specific LSM hook, security_mmap_backing_file(),
> a new user path file associated with a backing file that can be used by
> LSMs in the security_file_mprotect() code path, and the associated
> SELinux code changes.
>
> The security_mmap_backing_file() hook is intended to allow LSMs to apply
> access controls on mmap() operations accessing a backing file, similar to
> the security_mmap_file() for user files.  Due to the details around the
> accesses and the desire to distinguish between the two types of accesses,
> a new LSM hook was needed.  More information on this new hook can be
> found in the associated patch.
>
> The new user path file replaces the existing user path stored in the
> backing file.  This change was necessary to support LSM based access
> controls in the mprotect() code path where only one file is accessible
> via the vma->vm_file field.  Unfortunately, storing a reference to the
> user file inside the backing file does not work due to the cyclic
> ref counting so a stand-in was necessary, the new user O_PATH file.
> This new O_PATH file is intended to be representative of the original
> user file and can be used by LSMs to make access control decisions based
> on both the backing and user files.
>
> The SELinux changes in this patchset involve making use of the new
> security_mmap_backing_file() hook and updating the existing mprotect()
> access controls to take into account both the backing and user files.
> These changes preserve the existing SELinux approach of allowing access
> on overlayfs files if the current task has the necessary rights to the
> user file and the mounting process has the necessary rights to the
> underlying backing file.
>
> --
> Amir Goldstein (1):
>       backing_file: store user_path_file
>
> Paul Moore (2):
>       lsm: add the security_mmap_backing_file() hook
>       selinux: fix overlayfs mmap() and mprotect() access checks
>
>  fs/backing-file.c             |   28 +++++---
>  fs/erofs/ishare.c             |   12 ++-
>  fs/file_table.c               |   53 +++++++++++++---
>  fs/fuse/passthrough.c         |    3
>  fs/internal.h                 |    5 -
>  fs/overlayfs/dir.c            |    3
>  fs/overlayfs/file.c           |    1
>  include/linux/backing-file.h  |   29 ++++++++-
>  include/linux/file_ref.h      |   10 ---
>  include/linux/lsm_audit.h     |    2
>  include/linux/lsm_hook_defs.h |    2
>  include/linux/security.h      |   10 +++
>  security/security.c           |   25 +++++++
>  security/selinux/hooks.c      |  108 ++++++++++++++++++++++++++++------
>  14 files changed, 231 insertions(+), 60 deletions(-)

Due to the nature of the issue, I'm going to merge this into
lsm/stable-7.0 in a few moments so the changes can get some testing in
linux-next with the idea of sending this up to Linus' later in the
week.  If anyone has any concerns over this patchset, please let me
know as soon as possible.

--=20
paul-moore.com
