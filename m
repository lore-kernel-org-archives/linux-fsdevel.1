Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C667731AA87
	for <linux-fsdevel@vger.kernel.org>; Sat, 16 May 2026 06:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778913821; cv=pass; b=dcWw8YI32pR5ugsnMmEW9sOOLFnB1rnicMX+AJkJyIYj2+oxWoQndzAbwtj8k76Xh7FqnSRRiJ7joFyg28+Vdl6B6sb9mzFKPbkEUpDaNVmTGprzizk2/FX8EW+kcFSS5T9emDjNL96JJxP+H+AkU0ZtnR1RLju2bIuzElocNlE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778913821; c=relaxed/simple;
	bh=BOu7AkGfzBlU/bzal5lpBXqw/o4zx+y8OCCvr0FI1sY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z1arXFUwPUjb9kRyZYFqhLrYJcTkWqOjfPVXwVuJCHl/+dNSaVEzZ2EhinddvbJCt1QaFUbF9pjORyniIoC8sB3ZKNXeIffO+RmDQ2YaAavSSAbggS9nVyAuUUDDaCqOMvpP0tybf39tZK1XDXGmqNr6vPnqrXDEyLQRwKIQYIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lte6xRJp; arc=pass smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lte6xRJp"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-479d68a9063so213507b6e.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 May 2026 23:43:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778913819; cv=none;
        d=google.com; s=arc-20240605;
        b=ICX2DkIbdo09PHuDXOh/r3Eoxo42Vu+YK68ImPwGkXz9+kyHxby+PeZtTvHTBM6D8K
         oba9QKXJ8v1z9wskY6xrmxMfjrLdvcxNvXcGUDLdAMz2LP6PAET+IXUPXWSmHTgfX2eG
         XptBEWIkxTyrYcyLFPuxD5JKRBx8ZgJlPcS1uhBlKgzRbcE4Cf2l+TQ5kTs+r7VhNnQf
         fn9202Ymtnpk5OnsvZXqK6JBurBN/n8pwlOZOJPND4WhYpaGFfF2T+EKiDwyFveGaCiU
         f9OjFRvuWEUC1DN8fBv2YvOd+dO6dCEHOZroTkhL/yF3R8eP15v0ypmvje7LjFvQ4WmW
         Fz4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=9mxy2GpAHGinIR1PnXVMvug0ztGXvMspUp7huk1TMZs=;
        fh=rO+jgylqmkJQANbo84OJyiD+js8GAfY5ih+TTnzau6M=;
        b=ShpeIAQjXF2j21WcMIGsAwHJ5Iyh0MImMKMhhoX7L/Tz9UZqZEDaugKHq/tjfSOhR7
         iaE+fF4QuRmSG/EvlU6x8yE/Xt6iKbyOrutYsLuSZCLp/T4NriwDpjiAh008LnBSUV2i
         3yR/NjI90OHqCOLosNlA/j+ffkUQLG3OOvGhuOjGVYtOjoflpcuLRJyO48cGy8VGyDpS
         KrwtooM7/vjw8Thxg3JgmzQqcHSMMcvY00r6/WFI5p7F0Gq+p0GNE9IKqllW6p+hcGXs
         Vn4ZMUr4yy/GpsH5eYOp4V49lVb93AfREVmwa3TB7FQqSxIakQ1Pa/wZ/KpxeJU/OvfZ
         pAKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778913819; x=1779518619; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9mxy2GpAHGinIR1PnXVMvug0ztGXvMspUp7huk1TMZs=;
        b=lte6xRJplRGmp/PSskcPRMRcmRHxp/3AN6A1XynLI6uXZlluhAn8u2h7mZQg7APZLK
         oAbu6jVFzk3P9a62b4PsoqoTNSJkE7FzjLFpOPv5Z+lsxgwuhtlVTrcbfv9MbnmVX5Py
         k/kzYjGMlhm8+gRGJfuzaDpFjgrS5WI83cFpH15WHsjn/iy/5C/Ve0iDz9Octg/QEDrA
         DhdqK6z9WrgQK213b5HL2plz3FNcI+orhuzLw1gTevyVgHFRj7CbGxDhPlje1LF0RZp7
         KU79gd97VCPt1LjtMq72jZt/AsJhd9asWIZ2PtbrgPLo+/sBoYkMDD8j7+KHYkro1zzO
         kN5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778913819; x=1779518619;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9mxy2GpAHGinIR1PnXVMvug0ztGXvMspUp7huk1TMZs=;
        b=AQy6hTqqeeBH6+LA5wmhTQ21OfhLz2MsN/b0Fp54fOO1nNjPkgDxavKhJqh+AfWCzV
         AbCjia5P8npwJHOdocDP8xPusTcEUxqhCq4fSw4UgSMnOwVlbArddsrTz63rydMWAkYX
         l/yELjpeIaMb7EX0IODSaTd7wJ6VKYxQgEpf2Ge6zzJwycCXa04dOl89ab+GHAt6LdtC
         tDkyI9bmii5FA1/gTDxgZCWZxppydzJYlh3L2m+IQapgqoODCjY8QrgXD36rGxQfbia9
         ItKmTzUXdhWCKN/wu6K+gvsSCbVYEd2WCZ7+qk0E7cFfWnTyNgKTTHuLLkbPvubx2ulF
         /1dQ==
X-Forwarded-Encrypted: i=1; AFNElJ9N+4L261+Qs+ni7go8fyvpSX6KSj518OSjcfObinjyeLIA9eCVobVQqZXHnTQmQBsthf59OmcQomIJgM0W@vger.kernel.org
X-Gm-Message-State: AOJu0YzqbloPIzEjXGwYc7o0UBSieB49lSneCntJ4843LmiyIUU7xHGe
	9rKB3qp/e8EzpjmiG5WXbtsaufii84ZrIHDoaurT3/2woU3VzTMpgYC9zowOVfNuOwTaSpMr7iW
	3xCDWYLpU4foyQPDH82aJ3MP9KuoDDII=
X-Gm-Gg: Acq92OEZXfVAT3ekVxFeHbnsdBa2A4hF98S8m1mJP7EH+XmPUDKC5iqCxyaelwCH6VR
	UzMKZ66r9OkwfOWOxV+dbdF63ipIlc9NTIHRfe+r2ynZ0SPnEBIeCZDHa5LVLr4uqPFRKGEUBhC
	phy7MYvZGC0bKddmzgRINfwHbvGEs0THM31tfGwBdmLnv22lBUKIeFro0kEHSiyjiixXofMjty1
	QsSJHJGNkWhgLy9KVcblUA1d3uFHu59MiVuuidzIeH3PCCc2JG6ojcaU1IgnEWqBxyI4DKZbNXb
	tYy8l7snL0rz3RpUjg==
X-Received: by 2002:a54:4e88:0:b0:46c:e542:cc3e with SMTP id
 5614622812f47-482e55e65a9mr3386045b6e.6.1778913818672; Fri, 15 May 2026
 23:43:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507-case-sensitivity-v14-0-e62cc8200435@oracle.com> <20260511-wertverlust-vorbringen-070f016f3bd4@brauner>
In-Reply-To: <20260511-wertverlust-vorbringen-070f016f3bd4@brauner>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Sat, 16 May 2026 08:43:00 +0200
X-Gm-Features: AVHnY4LulXSgBXmlt-XknhPT4FGQR5_lEWwUy9GN7jO6BYSv7kvOdT0vcpcWCyI
Message-ID: <CALXu0UdsurG-ayuYViqs0HXOfgyDw8gpNC+f=5y59cuuSPUbBA@mail.gmail.com>
Subject: Re: [PATCH v14 00/15] Exposing case folding behavior
To: Christian Brauner <brauner@kernel.org>, Chuck Lever <cel@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	hirofumi@mail.parknet.co.jp, linkinjeon@kernel.org, sj1557.seo@samsung.com, 
	yuezhang.mo@sony.com, almaz.alexandrovich@paragon-software.com, 
	slava@dubeyko.com, glaubitz@physik.fu-berlin.de, frank.li@vivo.com, 
	tytso@mit.edu, adilger.kernel@dilger.ca, cem@kernel.org, sfrench@samba.org, 
	pc@manguebit.org, ronniesahlberg@gmail.com, sprasad@microsoft.com, 
	trondmy@kernel.org, anna@kernel.org, jaegeuk@kernel.org, chao@kernel.org, 
	hansg@kernel.org, senozhatsky@chromium.org, 
	"Darrick J. Wong" <djwong@kernel.org>, Roland Mainz <roland.mainz@nrubsig.org>, 
	Steve French <stfrench@microsoft.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 May 2026 at 16:11, Christian Brauner <brauner@kernel.org> wrote:
>
> On Thu, 07 May 2026 04:52:53 -0400, Chuck Lever wrote:
> > Christian, let's lock this one in. I will post subsequent changes
> > as delta patches.
> >
> > Following on from:
> >
> > https://lore.kernel.org/linux-nfs/20251021-zypressen-bazillus-545a44af57fd@brauner/T/#m0ba197d75b7921d994cf284f3cef3a62abb11aaa
> >
> > [...]
>
> Applied to the vfs-7.2.exportfs branch of the vfs/vfs.git tree.
> Patches in the vfs-7.2.exportfs branch should appear in linux-next soon.

@Chuck Lever Thank you!

Does that mean the support for case-insensitive filesystems will work
with Linux 7.2?

Ced
-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur
