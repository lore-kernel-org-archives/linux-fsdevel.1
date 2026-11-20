Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795133309;
	b=wciiXsniVTwV0ekeE33sWlSUrCNScSRmj51zaRb5zGogOub/2SbD0z/3I9wy0+TKo0BC
	 l10ZfdHPVNYGr1qqusDfpKpIItx2k4MokGGqmOv7s7Rxs16gm8BZ4AeW2LXsDIjAxeiAO
	 3jAImTH2t0hRXIbOU+4pcubyEiAY2kiBGJi0xKEdZwil8QqYc9Di2V+ZSF3Gyspyaynm9
	 OrwjKnV1HYQ795X2I5mVlwu8zRdX2GhUQkoTQp0yqz//YPkBZVrMsvyykVkSL3YU1vneO
	 PQ2myiDtriOSkjnMk1b7tps2TEh9N+FchBNOC2TnyH9d9mpqvkwvhs4RB1YdQsfG/mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795133309;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=cY4KOKijAqTkogDXZA4A0T9x7IyNskoXx3Xzbyw+6r8=;
	b=raSBX0alUZCyg2UwxEj69KjD0zscpgD01pHpCIhTIx++5D7qACkAK5qHPBQL5CWG82br
	 3huWLx8a5B24E65w2las/v505P7j/RhA5C/dDayVeAPFnBE0v+7Se2Fp0hA+mNisqpw2G
	 ltJp4qOdSEsUnjlWgIejanyGnR9h/Sm71Ka5PWpvVDpzeeRE/8rFllUulfl/FCRxjoS3Q
	 hqXc3c9YoTIi6tYCN5bgKcpVSQDfJWwRGitoGCSDwgUcOsKQrPGQLbq/XeydPLhUj9r0w
	 CL0c6pn9L4u12YyPcORuUI8bB+MVyuUCPVJ2AWhCGrziJcpa+6UqCG8mXh86T6OyJ9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e+yMDDFL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7915606A74F
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 00:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e+yMDDFL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 073AF1F000CF;
	Fri, 20 Nov 2026 00:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795133309;
	bh=cY4KOKijAqTkogDXZA4A0T9x7IyNskoXx3Xzbyw+6r8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=e+yMDDFLGB8vZJ7qCLQnRx0XeOJv1Xuuog+f0ZV+Eg5q3nwnJSYM2JiF2qHJ40KTJ
	 597/n7PU36jXl8u+E+TEGksC2GAcq/o874NIkg0jkEuLapGqNSMvdeacrE9e6BWM2y
	 cSsLtDd7Ne6ElWDsuEqr/L8z5CLo9ajqkCPzgFOVVUhcwZf2MvpatdqYSUW5LvJvT5
	 n0IvV1gE39ZceEjlPZU3h58pf+f+r09d91JMrheTdyV97gJXV9suCh7odLQ0I1afgy
	 EjAZ+i/U1CwGdtwuUO1Ap+gj9JK+W1Qj/lPdJFtfXKojJdOXqfv++HeosqVPbroOuL
	 X3151UCLfkEUA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 1678EF40066;
	Thu, 19 Nov 2026 19:08:28 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Thu, 19 Nov 2026 19:08:28 -0500
X-ME-Sender: <xms:fI__ag8_-NuJ-ReCnoxaNYbHYbkU7EbkPdgpv3t7nFEteasuUHisgg>
    <xme:fI__ajgnvbA0k45UpqIqyXg7258p2VbLNatwYWPCgr1uslLA-IG0glGK4B2T6wiWu
    Mlid21KrJ4YVLy9cVypgZn5JXjlhdWLr_rbDXbpX05ZcxwLrEKRKmbr>
X-ME-Proxy-Cause: dmFkZTGwE8ab5+73AgA18L75IUrv/V0PMeXfwC0gtXP2ujZyAQkq1KiG5x3GZZrEnA2ggY
    t4OlYbdiglv0Ji6batwgFDZ05JFOs3rrH/stiPCy4R1s9TGQXy7UjCgsczkGcE0WambDfz
    G4ZSd0C9exEUrTSycoVv17TXyz3YpAfbAjetJ/l0ZzeIfLUVBkbGxyG9kvBsaVVj+Ttqd2
    8KrVLa4OUKYdx+T7+M3o5oEIQkEO9mcy0oN4vK4Eey6CCSJRLnzgTF3Wm1b1OtBhhvm+LK
    /ha12CxgyBwWOgAJw43qdYldd0B+Je+bcpLJpTDopiG92Rinr2AptcSKtdNyeWURcXBNPF
    Xsq4RWV5LOW+0LyylKTNBp8GSlePxNiHepfB8KabxLb5Z2IlwZvgT3ZxlBV31E1ErLlVPj
    FeY55TsXUqlbohHo0lMI3OWbhiqeHHV/DDf43m1GTDLmf0b6DnPO5Y6U78KD95Rt8c6POJ
    HSyhmhMls4Lh8aJQzOVFlEHzrl2v0jIINY6wNfKUkGUkjLGtgnynzuOQxHstInsDY1/9FT
    ZLQFxJZIiR43/1/ZLS6k3iaZckkozJ/uDJxo0+GWSXiXDghfrsQfJS7maQ5+IC5V91PeRa
    H8iO43cbwYgzZDLFMAqIWpfLT68QII7GHJMkHSey6ImW0rUuhgZUbmFY3lpQ
X-ME-Proxy: <xmx:fI__auil3BDIB3L6_5umbz4SYDTlx26Qoi7u8eiy89gGkW4GH3GD8w>
    <xmx:fI__aglRj7-WvLu7z7ipDy4mBlx2AuYP2HBYMRWsUBoDmbmro0egSw>
    <xmx:fI__alUtqhuxZDU2rS7689M6ZTQMzLj0bj2mr05Oat9fysK2nFiaiw>
    <xmx:fI__att8ilfwEjeQF5AoGkq4W3DooNNRwrjSO2_OQXHr3yDwKLEN0g>
    <xmx:fI__ag75oH_AHuAXqXohtSyz1O1CtXxPwo-pb95x3QYDQVuoWj0UJQ7T>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id EB52F780070; Thu, 19 Nov 2026 19:08:27 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: AfOMpxdIrCIR
Date: Thu, 19 Nov 2026 19:08:07 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Dominik Maier" <dmnk@google.com>
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Christian Brauner" <brauner@kernel.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>, "Jan Kara" <jack@suse.cz>,
 NeilBrown <neil@brown.name>, "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Message-Id: <c029dfb0-0745-4b63-9577-1a373f7ff184@slotpi15m67>
In-Reply-To: <20261119192311.2684978-2-dmnk@google.com>
References: <20261119192311.2684978-1-dmnk@google.com>
 <20261119192311.2684978-2-dmnk@google.com>
Subject: Re: [PATCH 2/2] nfsd: enforce cross-export and may_linkat() checks in
 nfsd_link()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Dominik-

The may_linkat() gap is confirmed, and NFSD should enforce
fs.protected_hardlinks the same way linkat(2) and rename does.

Unfortunately there are some conflicts. There is already a
patch in nfsd-testing that addresses one of the gaps your patch
2 closes. So it does not apply to my nfsd-testing branch, and
if Christian takes these two, it will conflict with what I'm
planning to submit for v7.5.

I'd rather not drop Daejun's fix. I think the only thing that
could be done is for you to wait for v7.5-rc and rebase your
two patches for Christian to take cleanly via the VFS tree.


-- 
Chuck Lever (Come to NFS bake-a-thon! https://nfsv4bat.org)
