Received: from va-1-111.ptr.blmpb.com (va-1-111.ptr.blmpb.com [209.127.230.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D178379960
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2026 09:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784711153; cv=none; b=QPEB/iXUJ3FBrNGxVBXmhkSiNA1MqAGpqAK2Qq1HnQEwB9mUHd5A4GppBAQbgrr2sKM4gF33z7dQG0SvwxpeXv/CaC2AfyYmTTxn0RPK7JMXI/+5kzPDPKP9vO92tM+ULkLcA8r2/d+d+ehL6lnGAi5poOOvgTsBxFnOulTEEtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784711153; c=relaxed/simple;
	bh=idL1pQ1iwMzP26iwUM99p2Dl0/RyD20MhXH687h6bLU=;
	h=Content-Type:Message-Id:Subject:From:Mime-Version:References:
	 In-Reply-To:Date:To:Cc; b=Uy+hKm+kHK+HN4Fl2zRhO3Di9o407R5X+45z/GEhhRa6+ArfStZatX5n1Z0/UKDiES7OXTkhlV5SVWTG9lE2ZGqQQH/hLcWQ8Kx9/NhyWSmLZpxtLmsxm9M4QFi2N0goCoPx/eNltXqyDY04EOtXTcHlaPhmnDJbA6cMNApS7TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Z2pptxM4; arc=none smtp.client-ip=209.127.230.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Z2pptxM4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1784711145; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=idL1pQ1iwMzP26iwUM99p2Dl0/RyD20MhXH687h6bLU=;
 b=Z2pptxM4Q98WGdphPOKdEnoDTvUeLJzUlDNt2SzyCQQDAZETn1hePzf6IkqhVYvC0WuUlY
 q14q0eU4A+KYZ+sCUXQcO6DRDwCB47ivpVZ5nb+gyZEbt+U9qwjAqzCwSSxa0WKjA8hZal
 RfgRn+Swi6+S39ulO2lV+E5uZUu6IW86ktGoTpszQqV6LIYevTEBI6ijsoakuzb1Hgor7q
 bLAyieJoRoDsbFK580cODgZOs7D4FDhkxJ1ajc19iH3LNV8T3ZCTinVrzbQF5KI9qDn5oY
 YMJObd9pMPpzojWZrW3JRIe61S7rcGfmoIiINpOnyPIXVqs4Oen86608FT9yBQ==
Content-Type: text/plain; charset=UTF-8
Message-Id: <d9210bcdf73fbe1ac8b6ec132865609a3ed68688.09b664f6.f353.4822.b162.7adacf158333@bytedance.com>
Subject: Re: [PATCH v3 00/20] iomap: convert to in-iter iomap_next() model
From: "changfengnan" <changfengnan@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+16a6087e6+29eabf+vger.kernel.org+changfengnan@bytedance.com>
References: <20260720210202.1163861-1-joannelkoong@gmail.com> <20260721142842.GA11935@lst.de> <d9210bcdf73fbe1ac8b6ec132865609a3ed68688.7d28bf40.2201.47ab.bf41.5b700aefabf7@bytedance.com>
	<20260722090350.GC30516@lst.de>
In-Reply-To: <20260722090350.GC30516@lst.de>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 17:05:39 +0800
To: "Christoph Hellwig" <hch@lst.de>
Cc: "Christoph Hellwig" <hch@lst.de>, 
	"Joanne Koong" <joannelkoong@gmail.com>, 
	"Christian Brauner" <brauner@kernel.org>, 
	"Darrick J . Wong" <djwong@kernel.org>, <linux-fsdevel@vger.kernel.org>, 
	<kbusch@kernel.org>, "Matthew Wilcox" <willy@infradead.org>, 
	"Jan Kara" <jack@suse.cz>, "Jonathan Corbet" <corbet@lwn.net>, 
	"David Sterba" <dsterba@suse.com>, "Dan Williams" <djbw@kernel.org>, 
	"Gao Xiang" <xiang@kernel.org>, "Namjae Jeon" <linkinjeon@kernel.org>, 
	"Theodore Ts'o" <tytso@mit.edu>, "Jaegeuk Kim" <jaegeuk@kernel.org>, 
	"Miklos Szeredi" <miklos@szeredi.hu>, 
	"Andreas Gruenbacher" <agruenba@redhat.com>, 
	"Mikulas Patocka" <mikulas@artax.karlin.mff.cuni.cz>, 
	"Hyunchul Lee" <hyc.lee@gmail.com>, 
	"Konstantin Komarov" <almaz.alexandrovich@paragon-software.com>, 
	"Carlos Maiolino" <cem@kernel.org>, 
	"Damien Le Moal" <dlemoal@kernel.org>


> From: "Christoph Hellwig"<hch@lst.de>
> Date:=C2=A0 Wed, Jul 22, 2026, 17:04
> Subject:=C2=A0 Re: [PATCH v3 00/20] iomap: convert to in-iter iomap_next(=
) model
> To: "changfengnan"<changfengnan@bytedance.com>
> Cc: "Christoph Hellwig"<hch@lst.de>, "Joanne Koong"<joannelkoong@gmail.co=
m>, "Christian Brauner"<brauner@kernel.org>, "Darrick J . Wong"<djwong@kern=
el.org>, <linux-fsdevel@vger.kernel.org>, <kbusch@kernel.org>, "Matthew Wil=
cox"<willy@infradead.org>, "Jan Kara"<jack@suse.cz>, "Jonathan Corbet"<corb=
et@lwn.net>, "David Sterba"<dsterba@suse.com>, "Dan Williams"<djbw@kernel.o=
rg>, "Gao Xiang"<xiang@kernel.org>, "Namjae Jeon"<linkinjeon@kernel.org>, "=
Theodore Ts'o"<tytso@mit.edu>, "Jaegeuk Kim"<jaegeuk@kernel.org>, "Miklos S=
zeredi"<miklos@szeredi.hu>, "Andreas Gruenbacher"<agruenba@redhat.com>, "Mi=
kulas Patocka"<mikulas@artax.karlin.mff.cuni.cz>, "Hyunchul Lee"<hyc.lee@gm=
ail.com>, "Konstantin Komarov"<almaz.alexandrovich@paragon-software.com>, "=
Carlos Maiolino"<cem@kernel.org>, "Damien Le Moal"<dlemoal@kernel.org>
> On Wed, Jul 22, 2026 at 03:04:24PM +0800, changfengnan wrote:
> > Hi Christoph,
> > I tested the simple direct I/O path and did not observe any performance
> > degradation.
>=C2=A0
> Thanks. =C2=A0But no improvement either?

yes, I haven't seen any consistent improvement.

>=C2=A0
> I'll respin this to sit before the iter_next conversion and will
> send it out.
>=C2=A0
