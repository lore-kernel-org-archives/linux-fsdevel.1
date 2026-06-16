Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619FA426EAD;
	Tue, 16 Jun 2026 10:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781605374; cv=none; b=XCoMrvdgorlUqM+UibsXsn2jI0TFe+FMYgL49G0B3uu0ibwY/CSVkQweAWKUxUOuEXNf8pV7fPf8WEsRyUbi39S0vtYQ7w7ScA3lbWYs6SMWsoDqjNfAvL4wXvaFdH0JJV4Sb1ESvVNmEV+v4MnKBfXoGBtGBFLSYF8UbiH9d9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781605374; c=relaxed/simple;
	bh=4uptwT1BiB045qCWErJY62daLLjZ6PD11iMfWQsbY4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hn6Jgt1zxTjdtU8FmIgq6PFqoQa88y4MAE3IZwAJU3llcYKI951V4jkSIE/9rBEFmvc4TdVif678aCNpKRZY5xTifmb2xJ0dqqbD1g+mumEfu0KO7suXG/2VbGe6fa/n7Nfeu4jaaIA7g2WQeMpCv5nbY+/JxMQLp75qTA/YIQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 801F31F000E9;
	Tue, 16 Jun 2026 10:22:51 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: jkoolstra@xs4all.nl
Cc: brauner@kernel.org,
	broonie@kernel.org,
	cyphar@cyphar.com,
	linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfs: uapi: retire octal and hex numbers in favor of (1 << n) for O_ flags
Date: Tue, 16 Jun 2026 12:22:50 +0200
Message-ID: <20260616102250.3652779-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260604222405.5382-1-jkoolstra@xs4all.nl>
References: <20260604222405.5382-1-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

	Hi Jori,

> A recent build failure[1] exposed the diffculty of working with the
> current octal and hex definitions of O_ flags when trying to find a gap
> for a new flag. This difficulty is compounded by the fact that O_ flags
> may have architectural specific values.
> 
> Replace the hex/octal #defines, which are hard to parse when looking for
> free bits, with explicit bit shifts like (1 << 11). Also, add comments
> that identify which architectures redefine some of the seemingly free
> ("cursed") bits in uapi/asm-generic/fcntl.h. These should not be used to
> define new O_ flags (for now, at least).
> 
> The translastion was done with Claude Opus 4.8, and verified with a
> (non-AI) gawk script. The accounting of which architectures claim
> which bit-gaps in uapi/asm-generic/fcntl.h is also done by hand.
> 
> [1]: https://lore.kernel.org/all/agruPPybCx8q2XcJ@sirena.org.uk/
> 
> Assisted-by: Claude:Opus 4.8
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>

Thanks for your patch, which is now commit 0da79c259ad0554b ("vfs:
uapi: retire octal and hex numbers in favor of (1 << n) for O_
flags").

> --- a/include/uapi/asm-generic/fcntl.h
> +++ b/include/uapi/asm-generic/fcntl.h
> @@ -15,51 +15,55 @@
>   * When introducing new O_* bits, please check its uniqueness in fcntl_init().
>   */
> 
> -#define O_ACCMODE	00000003
> -#define O_RDONLY	00000000
> -#define O_WRONLY	00000001
> -#define O_RDWR		00000002
> +#define O_ACCMODE	3
> +#define O_RDONLY	0
> +#define O_WRONLY	(1 << 0)
> +#define O_RDWR		(1 << 1)

And suddenly all these constants became signed? Can't that cause subtle
issues, especially for uapi headers?

	#define O_ACCMODE	3U
	#define O_RDONLY	0
	#define O_WRONLY	(1U << 0)
	#define O_RDWR		(1U << 1)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
