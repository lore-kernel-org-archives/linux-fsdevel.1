Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F9227B340;
	Tue, 14 Jul 2026 00:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783990441; cv=none; b=ftEliLG5oSsN9zjO/wi97X5fTplbuJWRc0lqK7q9HfrybuvOFoMGbJ08Z7BLMP3GbB1xvDbPw1hpd3CPvhoxJnSuqJg70vyRBSfSBHivyVlfccdjHcj48qMA+K/2RYtDx3DPwoINk1LlckXNy143XpWFst+CvThtHkkXrez06C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783990441; c=relaxed/simple;
	bh=uTwDjKuMS1301WXC6hbErG0PUizkOJkzzwyV6byBpKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TEzc/v8WwAMtc6Gf3Zw+KM5VGGir8lrics9MxnA7vOPtzN4UrVApJ/6g03i0VVPS55+jmoxrcbg9bOedmxNGTxI4Mzm6CVAbqkfM+Q2EgBxZPgfjwpGriH0IQuEEkjPE+YvfMT1csX6S4RoAXyplIsQTFf1TLHvstfHxy5jlWHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lbddsCp3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lbddsCp3"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id EBA911F000E9;
	Tue, 14 Jul 2026 00:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783990433;
	bh=4bwFNpdAFUUPgCUlRuSPzM+uyo74pRXpoSUZKGd50Ss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lbddsCp3IsaH3FDAcveJY4eszWlrsowJZeKwFbmLg+flHooyMAAP8UabYGJgnud31
	 X3Yoxej6LAF6by6gKVM6TkODGmvczE5jwawD6SNOq+vHoRh3hyEzBKUAJU1TWNA/S4
	 pz2Y5hBc3Za3+orr+hd2C/6zb0ihaERD+U5JiNtDKNpnUIXkahwWNtIgJTPg+N/ZUK
	 XXlH9MwFYCywg/KJckq51dr/VcM9NEdpVJXbmcckvuVIJQBqaPeYjkVDRlGZPpukKB
	 JTWxI45+FInTOuqWIi70vvzoxQkZ9lmh8ymiaXZy3Dr5c/6mEa+5CDfaqwrb/8GMoM
	 9F2sO1MHm3Oxg==
Date: Mon, 13 Jul 2026 17:53:52 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Jeremy Bingham <jbingham@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, brauner@kernel.org,
	jkoolstra@xs4all.nl, jack@suse.cz, viro@zeniv.linux.org.uk
Subject: Re: [PATCH v3 0/5] minix: convert to iomap and add direct I/O
Message-ID: <20260714005352.GA7398@frogsfrogsfrogs>
References: <cover.1783707063.git.jbingham@gmail.com>
 <alSwnFoGwVBRVlu0@infradead.org>
 <CAMyBmMDj7e0t8J2rYTw4uBe9SMDx0Jyf1iDbbcKYMdq3zzEEHg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMyBmMDj7e0t8J2rYTw4uBe9SMDx0Jyf1iDbbcKYMdq3zzEEHg@mail.gmail.com>

On Mon, Jul 13, 2026 at 12:26:27PM -0700, Jeremy Bingham wrote:
> On Mon, Jul 13, 2026 at 2:32 AM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Sat, Jul 11, 2026 at 01:59:04PM -0700, Jeremy Bingham wrote:
> >
> > There's no point explaining each patch in the over letter, that's
> > what the commit log for each patch are for.
> 
> Understood. I've also read your other reply about how the cover letter
> and commits need to explain *why* rather than *how* and will fix
> them accordingly.
> 
> > How did you test this?  How do the xfstests auto group results look
> > with an without the series for minix?
> 
> I made a script that exercises about 40 different file and directory
> operations against each version of the minix filesystem. I tried running
> xfstests against minix with and without these patches, but it doesn't
> work under either case because mkfs.minix and fsck.minix don't take
> the expected arguments. I had backed off using xfstests for this
> because of that, but I'll revisit with the next round of changes.

Yes, please do get fstests working /before/ you start changing critical
file IO paths.

--D

> Thank you again for your comments,
> 
> -j
