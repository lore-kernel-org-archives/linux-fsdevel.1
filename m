Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCE73F074A;
	Fri,  4 Sep 2026 11:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788522197; cv=none; b=DO4InnG+DTuHf/KLEVUzgQiBx8Ef6dYf67kwLYMbc6/cliWokhvWL2n35wJzfPeesATgc/9FOCJgIGL1yCh1MqeW1YrcJ3BQZC1gWFL3xXP+OpP11m9PdynIxHrdSrHcDjoRE2Cw86QVBNztYf6xBJ150Kohv+w68oc9tq9v5Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788522197; c=relaxed/simple;
	bh=GgWGA3tRFjwasRcdaTq8NFprGOZYrgriEgoqozAWbas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C9km6rf3UeVgX1vkp/uBhjUNpOie+d5MbgiDaatqsZol5x9UducZ2sGCqQmvLi8RYvkv09dlO+ZXOOOSL6+wPqS+tWrp0DjPl6yvrCJPZudN5vbAuOXQ6jTEVq3Odjl+DVDGM1G71Y8/nASOgG8ND1N6ltT1hSbJw1OcXsptPwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=efkQZLkq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="efkQZLkq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49D921F00A3D;
	Fri,  4 Sep 2026 11:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788522196;
	bh=GgWGA3tRFjwasRcdaTq8NFprGOZYrgriEgoqozAWbas=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=efkQZLkqO4RDG32p3HDB8moibYfGgFtd8IwObc9ULUb9uy4aZBXv2JOkJtTz9C6li
	 KtIg1q+pF0wM/bOMpHN5Oh6qCpbIIaKAacLSD1Uq/WWlqNTeUbJsr2QW6E02nVhp//
	 uG4KoC9KTlJs8Ioscr39heJ6S+2Psr2BSfhULVwhom8MQbfXkgDA3BZ2tfDe7IabKh
	 BLoNMIVmNnCWY8HYpaL9rlMkrbwoBg0ErSuHzN6dluM8l37m5k1GTlhxmdNqCetxP8
	 zaZdI7hJn71deW1GZadBBQ7vdgi2JMIpmEQkTK6Wl9nMhlLrkPJcrkb6u1dX/r56sG
	 nGCPs3n+Zs5rg==
Date: Fri, 4 Sep 2026 12:43:04 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Tigran Aivazian <aivazian.tigran@gmail.com>
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Jan Kara <jack@suse.cz>, Jakub Kicinski <kuba@kernel.org>, 
	Namjae Jeon <linkinjeon@kernel.org>, Hisam Mehboob <hisamshar@gmail.com>, 
	Martin =?utf-8?Q?Kepplinger-Novakovi=C4=87?= <martink@posteo.de>, Christian Brauner <brauner@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Bagas Sanjaya <bagasdotme@gmail.com>, 
	Eric Biggers <ebiggers@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	David Howells <dhowells@redhat.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Theodore Ts'o <tytso@mit.edu>, Catalin Iacob <iacobcatalin@gmail.com>, 
	Stephen Hemminger <stephen@networkplumber.org>, Andrew Lunn <andrew@lunn.ch>, 
	"Maciej W. Rozycki" <macro@orcam.me.uk>, Andrei Vagin <avagin@gmail.com>, 
	Wei Yang <richard.weiyang@gmail.com>, Bhavik Sachdev <b.sachdev1904@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Wang Yan <wangyan01@kylinos.cn>, 
	Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>, Malaya Kumar Rout <malayarout91@gmail.com>, 
	linux-doc@vger.kernel.org, linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Luis de Bethencourt <luisbg@kernel.org>, Salah Triki <salah.triki@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] bfs: remove the filesystem
Message-ID: <apqtweK_abU7IsUc@gremlin>
References: <20260904082954.48738-1-enelsonmoore@gmail.com>
 <apqXNCL4X_i6xy2Z@gremlin>
 <CAK+_RLm9HKkm8YCCanpOMxaMaAkt5eoxQBHBxC1-Xkvj=L=UsQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK+_RLm9HKkm8YCCanpOMxaMaAkt5eoxQBHBxC1-Xkvj=L=UsQ@mail.gmail.com>

On Fri, Sep 04, 2026 at 11:18:10AM +0100, Tigran Aivazian wrote:
> On Fri, 4 Sept 2026 at 11:05, Lorenzo Stoakes (ARM) <ljs@kernel.org> wrote:
> > Based on Jan's feedback at [0] that closes the loop (it is indeed a
> > maintenance headache):
> >
> > Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> >
> > [0]:https://lore.kernel.org/all/35dsgpk5dsh6bm4xoblrq6hdslfvtuibl5grzag37cye2hgepk@rkrtkjxdyk5g/
>
> Ok, I won't cry about it :)
>
> In fact, if I may, I would like to say that it is a pleasure to be in
> your (pl.) company once again. Looking at the list of people included
> here -- some familiar, some unfamiliar -- I remember the younger days.
> I have done my tiny share of contributing to the Linux kernel as best
> as I could, but as I now grow older I can no longer maintain BFS
> (older does not mean inactive, just active at other things), so if it
> does give maintenance headache, by all means -- remove it :)
>
> Acked-by: Tigran Aivazian <aivazian.tigran@gmail.com>
>
> PS. This reminds me of d'Artagnan's phrase from the Soviet version of
> "The Three Musketeers" -- "my consolation is that if I am to be
> killed, I will be killed by a true musketeer" :)

Well I think that is the classiest response I've ever seen on-list :) huge
respect for that!

--
Cheers, Lorenzo
