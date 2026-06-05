Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219602F3C37;
	Fri,  5 Jun 2026 02:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780628038; cv=none; b=vEQcrXgf5UnTBrdJn2w5yjk+eXOd0XFF+9aSWx5DQrV3fNnNr5+WmsHMmbHGXI5C/ZQ6K4hYDMwu8FamR/DrSY9Zrr7Y28eAqBq5YOrVAW7C87pLoOhG2PY8KqAwDyoJwwXmIXH82c+w+FByIUut09SKaItYkjLh73KBerF9leA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780628038; c=relaxed/simple;
	bh=NbOtPMKjrwqLJnxSD7b238q91eHFIDKOQEctGVbaVLU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=nBrotxbXd96QtLtklDL9CrdTS/WgwcSzu/Nlq/gG+0GDPOdjRB5wcYWhkjvE/HXmJ65b3ygJU1GsjqRh7tay7ykCC6Hx/JtZP1rzTz8TALTr8JNhMm9DSdZsbowUyNgPpGv7sDWtofpEhomBFNZCnbNiEOnWax7KYs0HCdICch8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=oI8KkONr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="oI8KkONr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AEE61F00893;
	Fri,  5 Jun 2026 02:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1780628035;
	bh=0HRXtrKe5HtE4ZpMLgm3cRKoF5caP4KWsBckYzbZZE8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=oI8KkONrPDqaQVD7HAB4gGbCqT5K2ti1Y2czaikLUtac5ac0Mvj9Wv0x2O/EyCdw6
	 c5D3qPhYWAVszwC32zcO6p44XXEePrENhXEoK5irQZMTMieZz5WhEGnRnhDfB/sMfH
	 KPn0MxleZDeOTpn1NLFOZ90KOdeNnucofSrcLj6Y=
Date: Thu, 4 Jun 2026 19:53:55 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Maxwell Doose <m32285159@gmail.com>
Cc: Fabian Frederick <fabf@skynet.be>, open list
 <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: efs: Fix compilation bug and use pr_debug()
Message-Id: <20260604195355.c2446336f3f8cdefabadc697@linux-foundation.org>
In-Reply-To: <CAKqfh0Eu=sp3rfAGzhTPcx1Vw5p=sjxTigAWhkzskYrAWB9iWQ@mail.gmail.com>
References: <20260604202441.65226-1-m32285159@gmail.com>
	<20260604143040.61f70396c568b7433110fb3d@linux-foundation.org>
	<CAKqfh0Eu=sp3rfAGzhTPcx1Vw5p=sjxTigAWhkzskYrAWB9iWQ@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 4 Jun 2026 20:40:30 -0500 Maxwell Doose <m32285159@gmail.com> wrote:

> On Thu, Jun 4, 2026 at 4:30 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > (cc linux-fsdevel)
> >
> 
> Whoops, I guess I'm too reliant on --cc-cmd :(
> 
> > On Thu,  4 Jun 2026 15:24:40 -0500 Maxwell Doose <m32285159@gmail.com> wrote:
> >
> > > Firstly, the current code uses formatters that are incompatible with the
> > > most recent GCC for x86_64. Replace them and explicitly cast the
> > > formatted variables to their respective forms of long long.
> >
> > Please quote the compiler output in the changelog.
> >
> 
> It's rather lengthy:
> fs/efs/file.c: In function ‘efs_get_block’:
> fs/efs/file.c:26:35: error: ‘block’ undeclared (first use in this
> function); did you mean ‘iblock’?

Right.  You're evidently the first person who tried to compile this in
more than 20 years.

How about we just delete it all?  If some future developer wants to
know block numbers and stuff, they know how to use printk.
