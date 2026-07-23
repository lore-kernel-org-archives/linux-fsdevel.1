Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7F14D2EDE
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 14:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784815696; cv=pass; b=lo/U8Ti89JKX5k/tz7sKMVblWlpHld4qLSMS+oZJdWq50NLjm30K06reS4xd+vxtm3LFikpwcjIV7cbzIyw7ZHcdFyNS2v9iKe/4uRYtGkkP6c3wqE9A1b6PJqDiXM/wCliO5nl2gI7vUm7oKzuyUk2WjIna02br/+pU6GzPxBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784815696; c=relaxed/simple;
	bh=My0yYJ9gfBuiqRns4rQHBKbjK6CnjyaqD+SHjIQuSfg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fN1OnH10KuVngB7ixDVh1gMAC4adxcTOoIc4nrQsHzIvqtgZR0NOVmPtzclOLF5rVgYggsFTWjUZrHEjSwn+k13RBBrceb0BZx9qMJTF1FY8fdVH5MV3bgWZLaLxqlUfCbup8ytifacYsI4ehA/QzmQZLlep6ZvR+i9lj1Dn5ck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y986YNCS; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y986YNCS"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ccdf36f63dso120315ad.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 07:08:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784815691; cv=none;
        d=google.com; s=arc-20260327;
        b=nc6hdx7b+thc6mnAiYURsYqqBO0BX+2P1w6JR22BuSoM/zKlxV8R33lwW8s1GcY4pl
         WBlsY3/8yfkISUgsoeny3BV3O28ZbTJnyVSqGJB/vczlQUqLC8ep3bfMW41IB8pLv3w+
         7dAw9GQkht9bat9G6N7metuyee3z+j4p7lTLF0W0ktZTZglZg4mxaLdjjYdSsHmpG0YL
         FRpcRms0y4ZsajKT1hFIyAO9vH164RO8N51HSiLx/YyuUgeEj2tAk7Jz+YOSqbmhHYoz
         CTNyBdxtHHNAgIS1RxD+JQcWFVtS+2knaYmB9ld9eTD4VeHELz1lwlhfYdtSvCp60eCm
         oI9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=My0yYJ9gfBuiqRns4rQHBKbjK6CnjyaqD+SHjIQuSfg=;
        fh=P4/FJJ+Qj7+osEFnpXin3f6dV68D6CcW4ZR1vb795Io=;
        b=M0MWNe1W4jzgKtdIBJ211Mfero2VQJBLerE+XI6NmOUFJZZy8BI7W7sJphAt0rnTGq
         634yeFSt7ICXAYsaJYPYaxj491Kb8DtE5i6rjVVx4XE2hYuTJwD28h1ragrqdzwJpkDD
         RP4bMxzNiBuQ6L+7CvQ51leByUAGqRYrfVPGPAhIX7lNIzGShMkUXD8rSVXsF+09hP0r
         KiW2H43w+3ECW9N9ALkbxgoPSTy6tjYHU5NOtSlQa+A6wdreG3z5zSYji7puopb8Hwty
         foDRZC3h9rIjSL1kisWeCrZPtpb1LsCiHi4Wj7MSSFOWlXk7fifMVqakVpAI6v2v5Pnq
         I7Ig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784815691; x=1785420491; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=My0yYJ9gfBuiqRns4rQHBKbjK6CnjyaqD+SHjIQuSfg=;
        b=Y986YNCSkmgo72X6PBt396rFEQKIvPpqiCoYdJJjTsQ4n0oteOOFGO53kLlkR2dCVm
         PreQdE/OwXCQda9G1WvPG9jSRmatuVp24BqzBwhAEcMa2Ophfw+MS0QWg0IzoHRMOXY6
         a1KdU9O7P4i6SsHM6fn8XySnEGSw1XPcn2wIoIofWDzw//1TZxaV/6qDqE+i+BOT9DjR
         rhm8dIjJsUaWbSpxoXcR9Evp1KS2aXyh1GEMZ6wVcAigGpB+ekJV7mcqeVhEBjkqXzcg
         AdNIR/nYklwzaO4tJlNrN/UxFtS1KCxoU676bVdglVxmF8sUzxyW2oSAuEE/KCFInVkA
         bi4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784815691; x=1785420491;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=My0yYJ9gfBuiqRns4rQHBKbjK6CnjyaqD+SHjIQuSfg=;
        b=S+ChCWu1DXvhuGK7HPqclOE5LVlUWUylLZgU4UgGt6af61m7zqtd43+XThWpHda3Xc
         LUnwE6KJYPQdN0migphCI07+oJ+Oc1kQgAczXARHZMCXuxEkUqrBcy8VFvSbsAOPPbd4
         skcN0IyjRgQpnk5DrSeGPwjjCoOtYPCKV/yHCPk2RVYr+lF5DvBqHgTd+8RvyCR1QqZJ
         PZ5J0qQZc4zdIFbOC0gLQ6j404hMPS85/Id+/2TU5iTfpJTVyQzD1r+r1mb4GyYTmDdP
         o/RmleOLFMvS9Yy6FN97jql6bVbRVVJg9S5szN8XSWHYf5J48OaLkkdLbDZ1ypvp0CcP
         AMZQ==
X-Gm-Message-State: AOJu0YyanSW0OXb+8GbsPuUYpaaNz29vGaGeai0vrMsdnzS9wvpMNJ4y
	+qCuE5Jc/k20vQ21ScojwGChC/6prNQ8SUcAv356ArVATxJ+ICSxrVKzzZE+0g6V3bCu9B+tCkG
	67Z5w9laSZF1dCmTpidShC1baGkHKX/YA5UvqQV9k
X-Gm-Gg: AR+sD10oAGv14j3tnZkJEuDKjEfbtAhpWBz46YbKA7gmLVCS8TJUXgBmIMB+Mh6Tzbl
	4mn6nvSRblqQujyuUm0cSymyO32qnysNOrPgU/TXmTAEt8bJdhRckLwovzV74IHG1OQuLLmi77v
	z25q7v2Le2csfMl2xmLsWFLLb4/Pjo/sdTnoo2PRaguBre7QQm0xnuwC2DFjVswY+fDe4zMbnJG
	UhAjzl1zncMKTBZYE7fW5k/ejVM0Ry9ld0KexQz5GyUCVR3rpkidH6VyT3gHtQLHvCVzoS4Shw/
	k9/nOVYDQstOmWEUmFtkvu/gAq7n45CVihGFQGqJmBGgTDbtonfVUqW+YQ==
X-Received: by 2002:a17:902:c74c:b0:2c6:cbcb:bc72 with SMTP id
 d9443c01a7336-2cfa80814ffmr2462775ad.23.1784815690567; Thu, 23 Jul 2026
 07:08:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723-work-failfs-v1-0-3f69b9a9e958@kernel.org> <20260723-work-failfs-v1-4-3f69b9a9e958@kernel.org>
In-Reply-To: <20260723-work-failfs-v1-4-3f69b9a9e958@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Thu, 23 Jul 2026 16:07:33 +0200
X-Gm-Features: AUfX_mz_mzCvw2h5o1pR1qMvYWw2B5M-LX-GbZFx68Jm-lMghOI_PEmMW2ywzbo
Message-ID: <CAG48ez1psv82Y98XT1p7vujYgj5a9hbPZ4=h7x4-yXQO5FQr6A@mail.gmail.com>
Subject: Re: [PATCH RFC 4/7] fs: support FD_FAILFS_ROOT in fchroot()
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>, 
	John Ericson <mail@johnericson.me>, linux-api@vger.kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Kees Cook <kees@kernel.org>, 
	Farid Zakaria <farid.m.zakaria@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, 
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 1:30=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
> There's also some thought needed around shared fs_struct state. It's
> obviously possible to chroot into failfs with a shared fs_struct if the
> caller has CAP_SYS_CHROOT and shares the fs_struct or if the caller is
> no_new_privs and shares the fs_struct. The non-chrooted-currently
> requirement still applies.

Having CAP_SYS_CHROOT and sharing the fs_struct should not be an issue
because we already ensure that any tasks that share fs_struct are in
the same user namespace, so CAP_SYS_CHROOT is implicitly also held
relative to other users of the fs_struct. (In particular,
userns_install() and unshare_fs() ensure this.) (Except if LSMs get
involved with weird policy, I guess.) That's what makes the existing
chroot() syscall safe.

But yeah, the no_new_privs check I suggested is kind of a pain...
