Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A454BCAA6
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 12:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784811246; cv=none; b=mQ/dPbB9ZH7ZHD3fq69ysv0HoSC+8RajsOi9m8syXUG3yX2ozTw7I3QB+UobpQ7NuzuughmRsJFl1M2AmDc72fr/Kjy6gP6+eXp2WbhhhEbAb/+dkRlgNxXcauxY83ZtA9QaO5x6qNEOYGSNJCo+OZSt5YKFUar6VwzaFmxbvPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784811246; c=relaxed/simple;
	bh=hZB8/53s4mO4kIFJXxMOcWTQ6DBSxoSBcbhXg6lHpPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EtFXiOtHzRVy39Wa0W7kWX9NaI4RoKL89Nn2owwhgBXVbKqLrkha0j61yJdM8sDsET2AWev868VzBx3DTKRKXRbhLDd3M8oWfM16pewRfN+SEeaB9IzBCUrkRQKJK4YdhpHDGQ7eWK3IqypN2Ds0FhawT9qXAmHSqGKqLLwYChg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF4371F000E9
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 12:54:04 +0000 (UTC)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5b28c91fba5so505824e87.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 05:54:04 -0700 (PDT)
X-Gm-Message-State: AOJu0YylVOj1KVJsC4Mk2WB3EljYSWjC53c/k53xGlSlSTv1yvZJcwGs
	bfZBhulSIUokelTIuZyq3aiPVMgmXqYxPOgXl9BkKk2u3jTBMUYPcuyhK/GyLgApY37sabsqt5v
	ja4ae/WTLscRV3Q1G1CkAtZhs3NnvFsELHQfAnAgX
X-Received: by 2002:a05:6512:1323:b0:5ae:a4a4:b6ca with SMTP id
 2adb3069b0e04-5b2b3332127mr450440e87.14.1784811234312; Thu, 23 Jul 2026
 05:53:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723-work-failfs-v1-0-3f69b9a9e958@kernel.org>
In-Reply-To: <20260723-work-failfs-v1-0-3f69b9a9e958@kernel.org>
From: Andy Lutomirski <luto@kernel.org>
Date: Thu, 23 Jul 2026 05:53:42 -0700
X-Gmail-Original-Message-ID: <CALCETrXSDhrDzdGsknz0EpZkowm3OAPihyEU5Xf_Mb2CTr0SmQ@mail.gmail.com>
X-Gm-Features: AUfX_mzGKgWr2cRO8ep-8-hB43raCc8FcPMOawRl5wUYGrxfGA1kDuSSAZzVQBw
Message-ID: <CALCETrXSDhrDzdGsknz0EpZkowm3OAPihyEU5Xf_Mb2CTr0SmQ@mail.gmail.com>
Subject: Re: [PATCH RFC 0/7] fs: add failfs
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>, 
	Jann Horn <jannh@google.com>, John Ericson <mail@johnericson.me>, linux-api@vger.kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Kees Cook <kees@kernel.org>, 
	Farid Zakaria <farid.m.zakaria@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, 
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 4:39=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>

[snipped excellent list of things one cannot do with failfs]

> A plain readlink() of
> such a link still works and shows "/".

This seems awkward to me.  I feel like ls -ld /proc/PID/{cwd,exe}
should probably show something distinctive instead of "/".  Maybe
readlink() should show "[failfs] /" or similar?  Both admins or
developers trying to see what's going on and CRIU might want this.
IMO it's too bad that we don't have a nicely parseable readlink output
for oddities like links to deleted files, but oh well.

--Andy
