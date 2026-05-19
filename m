Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670EF2D9780
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 04:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779163569; cv=none; b=O6zYDMoDvhTjR3SSatwCFxTV0EAdRmzfuQl3gafQDNZybn9Yp49He5zPVjTpSS6oQWZ4ScJ+yNLl5HCdxaORrejuizOSgTQ1mJb5A+28SaU/vF9EVhd7xiGqoUAPvvjznlufINN2CwkkggamT+Vucfa59ISLjIPYr5D5aqUgMHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779163569; c=relaxed/simple;
	bh=TFtKvkqSmVglajIZbv2s6GNPVQl0Ay7wUk8iLq0id1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lE7ZMDyv7Vi/4Lui0xVNMC2gjNjOpEoq1vyoNz2m51o8vm0t1M6m65p2SlbEtHDJk2IGrrI36fXjVfg3gPIiCxlNZvWHZz9jgRrNq70lrgWlkkSGOaU8gEWAAdYJByUlhGs0ZBSC93h9KsAb1BhPFj8fwS2SjTPgaxmOP1hbST4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UPN5rdUg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UPN5rdUg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A9C4C2BCF5
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 04:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779163569;
	bh=TFtKvkqSmVglajIZbv2s6GNPVQl0Ay7wUk8iLq0id1M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UPN5rdUgUCnPoAhTORqK/95c0I3AaegDbg1Y69KznOen5rm7f+N1KJGmeduSC7UP0
	 8+t+Mms8JjpntqeGr2pnXvdk2WJ+U93SKxtvuyZKcbPdsEd7cNSemA3rLyxzlktydC
	 bBxGfd6h+xc0MYYZt7bmTPPu8oWw2Wqvj5+4sX2ASWyUKM2ZWWkoyJ2ZWyrkf9jkY+
	 xmQhIcCTNfX96FW1oQ83pFYWfZacGwHXCCLXUOFTxD7yJxttKHU4fmGY0mQusO7WPS
	 rPD5EjnLKjoMKtHuxWO6ZF63D8KUtUkn/oWmtLDg+3XrSv4XLUlkQR/5cA45ZlD19o
	 4XOsN720icrDQ==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-67179ed133dso3693073a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 May 2026 21:06:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+9k+fA+FvnNn9Xs/z6lZE1t81Kp6Glxqbo9FWFfzDcSVGDBVCp2eg0g5V0b3tRoLR88btAqjwG7WwibQVB@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl6iDrv87lmUzoMKZtJVQF5icKDIGH/Xi9xpY/jelA8zg/iTX2
	QV9NZRZQdl4xtjRMXVYY8KN8ktSGAuBHY7UCcJ/Bd80MhIgKlCJsCIbbHt4tNRs+3TUXHdGCPzf
	R84mpSzq7L8btRfhZGK4oa7QnKEzO514=
X-Received: by 2002:a05:6402:2498:b0:67f:7972:1c6b with SMTP id
 4fb4d7f45d1cf-683bd39234fmr8594287a12.16.1779163567680; Mon, 18 May 2026
 21:06:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518114705.9601-1-linkinjeon@kernel.org> <20260519034023.GE9531@frogsfrogsfrogs>
In-Reply-To: <20260519034023.GE9531@frogsfrogsfrogs>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 19 May 2026 13:05:55 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9NSEncE=qzURH3fo1T6k9GNzB9zssr4aDK5162d5oSxQ@mail.gmail.com>
X-Gm-Features: AVHnY4ISfqJk_4SzEuYrViNKSoOKHYgcypg6H0Gr6h6JVzX7XHmiVxY-yZ1eCc8
Message-ID: <CAKYAXd9NSEncE=qzURH3fo1T6k9GNzB9zssr4aDK5162d5oSxQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/11] exfat: convert to iomap
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: sj1557.seo@samsung.com, yuezhang.mo@sony.com, brauner@kernel.org, 
	hch@lst.de, linux-fsdevel@vger.kernel.org, anmuxixixi@gmail.com, 
	dxdt@dev.snart.me, chizhiling@kylinos.cn, chizhiling@163.com, 
	linux-kernel@vger.kernel.org, charsyam@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 12:40=E2=80=AFPM Darrick J. Wong <djwong@kernel.org=
> wrote:
>
> On Mon, May 18, 2026 at 08:46:54PM +0900, Namjae Jeon wrote:
> > This patch series converts the exfat filesystem to the iomap framework =
for
> > buffered I/O, direct I/O, and llseek (SEEK_HOLE/SEEK_DATA) support.
> >
> > iozone benchmark results (4KB cluster size, -s1g -r64k, 1GB file, 64KB =
record size)
> >
> >                        1 thread                  4 threads
> >                      Write      Read           Write      Read
> >                      (MB/s)    (MB/s)         (MB/s)    (MB/s)
> > -----------------------------------------------------------------
> > exfat + iomap patch   332.7     418.1           78.6      82.4
> > Current exfat         278.4     415.1           42.1      38.0
> > -----------------------------------------------------------------
> > Improvement           +19.5%    +0.7%          +86.7%   +117.4%
>
> FWIW I scanned over the other patches in the series.  Nothing stood out
> as scream-worthy, though as the maintainer I'm assuming you're watching
> them closely for the kinds of QA problems that only an exfat expert
> would know. ;)
I've checked it against all the potential issues I'm aware of and no
issues in my test-sets either.
Once IOMAP_F_ZERO_TAIL lands, I plan to update NTFS to use it as well.
>
> Acked-by: "Darrick J. Wong" <djwong@kernel.org>
Thanks for reviewing the series and giving your Acked-by!
