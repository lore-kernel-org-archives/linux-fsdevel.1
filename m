Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E3D191F98;
	Fri,  5 Jun 2026 20:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780692371; cv=none; b=qpjNswBcBzdVtNlBDVWhjEyvD6LcB6BHM7vXSY2/2UTIZw0L/9sxDhZ7mFelRvFdRpsSnm0Na8/wyJsaUN7uA4fMawMWewlr/IiZWYeDjhLHk6oeIAhQvrTs2ilcxKDNMouhIpv/4GYM9rYvDb2nUdBoWUZuBXRqKsfX6vUQkQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780692371; c=relaxed/simple;
	bh=oh1ZIY5u99lkiYQrcOq70ItL/PTCCLdIcAvyd2x/HxY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=gr7yx4YcK7eRDHASsCJf8Pa96rChyq+KvgN8trQZp0ofQaOp9cMkMrEljixv8Vof8clcm1x50HCPh3U9g6C0SstLaCkg21UH7n8HbiWlIbvs4R4+iMbIyOkwthw5GafFI/sOgdGbW7i45eHGhnpj5qfpE9kBx3W4LmHShDzuVhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lolrdDiF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lolrdDiF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DB511F00898;
	Fri,  5 Jun 2026 20:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780692370;
	bh=+pS5pYRv1b1oxX1uUim7VWULBoOcTnWxgaXvW3fib5U=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=lolrdDiFdL9uMbwZW0xaxa+9EToQumI7xWyf5aR9xufW4oLSzN/1G2w3g/2Ki9Rni
	 1iSKwy273sNCPtt0jWGOaQLCsSlVsbu6my8hKXKdoV/iscpgyGSbsdkatrE2hDXn3Z
	 SxNbGM1GQ5aevHrDpwL3QFcBkIavrdKVbWyyEeLBA4GZNMM2dLkg0/V0pLwTrAowqE
	 v26ToVzUDhYyx8iTs/c0Izox8bbSStteCVMgVxipRW9W1PqngkX42G67///WeOIM+s
	 0elHD71JnMDiTUNnXBlt4gD73QLffoPGh7hsuJRbEi87FJn02OIEdaewU/nAoHYKzT
	 x0WCrAxp1C6bQ==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 54D50F40094;
	Fri,  5 Jun 2026 16:46:09 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-04.internal (MEProxy); Fri, 05 Jun 2026 16:46:09 -0400
X-ME-Sender: <xms:kTUjan2UaUATh92afTQTXZTgnrTV9tl7tUv7ElNMlAa7BdYaCth0Hg>
    <xme:kTUjag5bJ22Ge5Y4N5I6U0LcVzb3WDJOpFsH3YkzBh2Ig11OJCC6tTsdDAqK5XAx2
    515_LjUyKCELIr6py0q0GuShFNMp1lPFL6Nlw113P2d4fDwdT1-yVY>
X-ME-Proxy-Cause: dmFkZTE9M6OwFYbaGgHuMO+298SUvU2ZdPv16us9lz/EmEUcWMpmvM5BF33oMZUGi27jcO
    3idG/YgwN6b2DDA2QEaW35oeSw9blA+ZoU3mmQ4uvpG6LVw7hJpzOov2STVAy7REp3fq7R
    2VQjUBxFu8RsUbJea69ZT+NJzCO2AHhn3LWtyu8/zs3bb/QwNVQfKJJaiCu6O+X4B8tRl1
    m+lzX2urR3pp2QmLj3Wpev0c4yO+dgOLbvSuAd3lImsJP0lViqS51LF/9YtuF/MkzVq0yn
    WPMne5Hu8YeRPI29OKpvHdLkZtRaS95oTwOubFrOHT3hX8+suIRYwCcyHalKPaOl/btnAA
    MH7UOkklPl6YLChEPCf6vGcSF6Mtevq8q4XqM4voiKXo3otBEEoVbE+BC7Skg2agoNQ/tE
    TvJdU7yIdHIdzTRm886sTjP1Kwsl9K8I+qEIgo4cPQruDXYaCIs6At7VdJ5P3RVI6ylZBR
    baQBBg+7VUQV81CiBAPQ0NtdvjbH5n1JE6tE0cG8zf0iuAFKNasjPBrCrpZNyVvR9uMUvQ
    DwN3QfYJN35QxLbq5Z94NfObgICAFEYBRawIbsxkjPmifnzEdXUJJyTpyzer2tgI6jv6Ee
    S3SVH4jx1N+oCjwNyM4v81u3Te4WKAvSgsrNBQqMmVEu3Dl6NoR2fZg4AmUA
X-ME-Proxy: <xmx:kTUjavwj3Ij3egkn7KK2qvfUlJGaaA4hWWsNkhamg6QYl7KLOf0HxQ>
    <xmx:kTUjato4yhQmWFDWRpa2IkQrSiwbPSPvnL5DVIfEc5TDKEb712Vaeg>
    <xmx:kTUjalkyFnt1KCESYACBrxelF8lz0EnnVyRAbVrHupkuNN2HWvRYag>
    <xmx:kTUjanUFKVckxP42yUAW5kWvOjuPP-ECkgiaj_ScnE4C3LjllbYjLQ>
    <xmx:kTUjapp7JA51gQXL090PJBDFYtxMNbedvh0rhttxtdB5Ge75mEmETSDS>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 32AE11820086; Fri,  5 Jun 2026 16:46:09 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AqrEF5vWDDS-
Date: Fri, 05 Jun 2026 22:43:21 +0200
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Arnd Bergmann" <arnd@arndb.de>,
 "Andy Shevchenko" <andriy.shevchenko@intel.com>,
 "Richard Fung" <richardfung@google.com>
Cc: "Eric Biggers" <ebiggers@kernel.org>,
 "Miklos Szeredi" <miklos@szeredi.hu>,
 "Nathan Chancellor" <nathan@kernel.org>,
 "Nick Desaulniers" <ndesaulniers@google.com>,
 "Bill Wendling" <morbo@google.com>, "Justin Stitt" <justinstitt@google.com>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
Message-Id: <0e2cc9a0-4bfb-43f9-8af9-1d68e8ef7aee@app.fastmail.com>
In-Reply-To: <65434490-978a-412d-b88e-3dff3bc75164@app.fastmail.com>
References: <20240730142802.1082627-1-arnd@kernel.org>
 <20240801010953.GA1835661@google.com>
 <CAGndiTNdCGuHRmnp+G-=_PzTaLXnUZpuXAT8dK-wdoG7Mpwt4A@mail.gmail.com>
 <aiG4suLcgILS8Hha@black.igk.intel.com>
 <65434490-978a-412d-b88e-3dff3bc75164@app.fastmail.com>
Subject: Re: [PATCH] fuse: fs-verity: aoid out-of-range comparison
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Jun 4, 2026, at 21:48, Arnd Bergmann wrote:
>
> I have nine of these in my randconfig build tree tree at the moment, and
> with my patches I get a clean build with the warning enabled, I sent
> these patches when I first came across them, usually after a code change,
> though some of them may be old:

I've pushed the remaining fixes to

https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git/log/?h=Wtautological-constant

I have not yet gone back to see if there were comments that I
need to address before resending.

       Arnd
