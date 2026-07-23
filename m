Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3515639021F
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 16:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784825836; cv=none; b=andtfTOHaJnla92+o8VN7xo8reolFTDLmiiOsDu5+kE9MwEl4jaPWpwDwXwpCJOcOyq2y78B6hePzD55X5cIO5ogLc9twEHDBcrjwIYePLsgV77icEwUSLjNESH2DXdeNOeTOJzFMPuAQOqkoOlc8+/1VcP5vAVcTPWosXcXn/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784825836; c=relaxed/simple;
	bh=PqykRVSsrwSwBko7HpI/DI8kB6OMIzURdtEjH0bl4go=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qsTFOTCMGYPZ2ouwukBt4xZQeP4a5zIjgwW7UjSG543btCDfk6OVbuPlGBP5lApRF9w2ey9DmMd5TBcT+dynAdweyfyMz5mFSQcE6S0bpjLEdO9HSZgsS9MS1rLBKA1qC10ZvHptpmezmM4yj6vud7+gHvQNRSViRs8iLspP1RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PQpS8yaK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQpS8yaK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBBBF1F00A3A
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 16:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784825834;
	bh=+pg0P9VSl+esL6Lh7ACV5pJPyjNye2t1udGbPDB26mw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=PQpS8yaKHEs69bBkBiSeaIzScFaz9EEGscY/9k3x0FgH3t5mYpkasoMEvggf3kNd/
	 9Y5vwKDL/65nUMOjqiPx3g/491H5sjUUk4QSA1OlKKegUj+P7x7DhWoiKH9RGdJ+0z
	 SPlXKYuoeqEgk5siXqBaJaSkW9itjluNj0TKAiIY6cJNpKUoUvVK0cYhJZ79E5gG6J
	 5oYsFjhy9xyBGNgzrRWdp8lfzys8z3mGn8pohFJQayHUwsyeHKbSMPFoTxhZcDVtoT
	 iM/Kxk1jrVd8jw1W4O4Rt51o1htIrP6mt6+rgDg1OunGOiY56GrQnpecTg8d5SdNLp
	 LCeZymzUFJk6A==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5aeb98460c6so932430e87.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 09:57:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rot2e/D5UbUF3OSNOJlqh9QQ150LWNdJWn4VF0U8e3QNcO+b+oWj8anArn21tI+Osg+6HDpPA6n0OoHvFqu@vger.kernel.org
X-Gm-Message-State: AOJu0YwHeAhUl/+I4UcHUcRXV9fLSJTmq0P3koGl4PZjKsz+QEFPk+uX
	EZCIBNrbQPYIoWIDw7+sXwTIwjfpO+S6XEp62XizojPw3G+fiJvuvvogsnTTHbBJ0ES57+YhFE3
	wxNaDp86JcMy6yMjYIJEBe55/c33k42e7TekgtQt5
X-Received: by 2002:ac2:4f0e:0:b0:5b2:aa5d:9d34 with SMTP id
 2adb3069b0e04-5b2b2f67c26mr858207e87.32.1784825830324; Thu, 23 Jul 2026
 09:57:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723-work-failfs-v1-0-3f69b9a9e958@kernel.org>
 <20260723-work-failfs-v1-4-3f69b9a9e958@kernel.org> <CAG48ez1psv82Y98XT1p7vujYgj5a9hbPZ4=h7x4-yXQO5FQr6A@mail.gmail.com>
In-Reply-To: <CAG48ez1psv82Y98XT1p7vujYgj5a9hbPZ4=h7x4-yXQO5FQr6A@mail.gmail.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Thu, 23 Jul 2026 09:56:57 -0700
X-Gmail-Original-Message-ID: <CALCETrWPQt5JJMiYcO_AdPbeK6zdDJVP71Y38YQ6x9VjcxAPig@mail.gmail.com>
X-Gm-Features: AUfX_mzjeayKkjWxi2CZUKV0qfPJXJwMd1SYkEprE_1eyDdsypuvQgPpb3epMK0
Message-ID: <CALCETrWPQt5JJMiYcO_AdPbeK6zdDJVP71Y38YQ6x9VjcxAPig@mail.gmail.com>
Subject: Re: [PATCH RFC 4/7] fs: support FD_FAILFS_ROOT in fchroot()
To: Jann Horn <jannh@google.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	Andy Lutomirski <luto@kernel.org>, John Ericson <mail@johnericson.me>, linux-api@vger.kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Kees Cook <kees@kernel.org>, 
	Farid Zakaria <farid.m.zakaria@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, 
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 7:09=E2=80=AFAM Jann Horn <jannh@google.com> wrote:
>
> On Thu, Jul 23, 2026 at 1:30=E2=80=AFPM Christian Brauner <brauner@kernel=
.org> wrote:
> > There's also some thought needed around shared fs_struct state. It's
> > obviously possible to chroot into failfs with a shared fs_struct if the
> > caller has CAP_SYS_CHROOT and shares the fs_struct or if the caller is
> > no_new_privs and shares the fs_struct. The non-chrooted-currently
> > requirement still applies.
>
> Having CAP_SYS_CHROOT and sharing the fs_struct should not be an issue
> because we already ensure that any tasks that share fs_struct are in
> the same user namespace, so CAP_SYS_CHROOT is implicitly also held
> relative to other users of the fs_struct. (In particular,
> userns_install() and unshare_fs() ensure this.) (Except if LSMs get
> involved with weird policy, I guess.) That's what makes the existing
> chroot() syscall safe.
>
> But yeah, the no_new_privs check I suggested is kind of a pain...
>

It's dorky, but we could say that your fs_struct must be non-shared
for unprivileged chroot to be allowed.

(I'm so mad at Docker for blocking *all* unshare calls in their
default policy.  Not a showstopper, but it's extremely annoying.  Yes,
I have an issue open that has been completely ignored.)
