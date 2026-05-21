Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE22381B17;
	Thu, 21 May 2026 10:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779358457; cv=none; b=ZrKT1lTaLKpGS9Fwrf8m3tp0jBDHBX+LwSfUURHXj77MZirVzgyPAI9mws1n1YoLL1HWECUVfv1udMV5tjbXBa1/ULR15YOrns2mRoznzL1PiOfzqDWz6E3RaaWXGxVRkJFyZMGDJmiEMVGP2E1zm7FuPR6utS4mHb/llmklncQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779358457; c=relaxed/simple;
	bh=0JU0hQFF8Z6bcVQaXYnbX5wCbDlTR/1jKFDX7gd+Xfs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gQ+nAuJ0FaHlWUIqn6wt58Wc1d67OLjglouaHX523oiwYgHgp5QJ3T4W47d7lgdYtqbpBa/sWbHNssJFm14RYOQRUHVtGDPYv4VTEfT4BMtOlzgrT/yFJ1DDUGMenIVUo/y+P2gcr3kjoGR4Qe+gqBy6kHdd35djP0wf/FgLAps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=vOaV+bZ2; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="vOaV+bZ2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1779358435; x=1779963235; i=spasswolf@web.de;
	bh=0JU0hQFF8Z6bcVQaXYnbX5wCbDlTR/1jKFDX7gd+Xfs=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=vOaV+bZ2lr3Jav1iQ1xEdWjIvBEC4OlWvK3m9gDAC8Pn7/UJGpH+h1NCf5obDTyZ
	 t8gk8uzkDLgS1onZP2lxv5QPB1kBu0KdgEC9SoXX8kr9mEsGvZOzrbEf36noRD8Pc
	 DhTakDX621i8v0vqMkH6sDuYmNfpPcQxHqCNXt3OOWOpAm3cJzGSg4faD8UCyweHY
	 2TMvUIwIEsrdaGkxuTiFmEkILOJeByfFC8QIbiR1B7sT8XmuiXTsNM2CuU5zcnVQq
	 H96QBWkj/QUbZNSEr3nVOUqFVuf0FLcDfi5EWzRemNIq+izCifGhmCHLVxhrw4QQt
	 rnwos8npTmE/xUNAVw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mpl4x-1x9Fmw30WL-00qR2n; Thu, 21
 May 2026 12:13:55 +0200
Message-ID: <af66eacab6beef90c53880befde3d4baf6a8e383.camel@web.de>
Subject: Re: context switch within RCU read-side critical section in
 next-20260518+ with PREEMPT_RT
From: Bert Karwatzki <spasswolf@web.de>
To: Thomas Gleixner <tglx@linutronix.de>, Mateusz Guzik <mjguzik@gmail.com>,
  Christian Brauner	 <brauner@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	adobriyan@gmail.com, jack@suse.cz, viro@zeniv.linux.org.uk, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>, spasswolf@web.de
Date: Thu, 21 May 2026 12:13:54 +0200
In-Reply-To: <87bje9w00o.ffs@tglx>
References: <20260520225245.2962-1-spasswolf@web.de>
	 <fnrz73n5jojl2wlbgrsjdtu5zuwykwbcjzznaijbquuovpoand@i6ihdqn7a6zv>
	 <87bje9w00o.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BJ+XMPrsfCW3Fi3gTMkaguNAj1ZKsyGiZuKFWuJq7y5xisH3bF5
 9LdZk167iw5rzQJxSLIUb+E074XtiOwT+Q2QIQ/h28Q5Xp/fDrC1U+i0cZw9jlPWYViwf2f
 8g5jtlSiNiXrj4257vAu3Dg38My+FuyD9fBe3F1crvUouuVToW5/yA+33j0/pceBqVlULb4
 ue/k+0gdim53IVlwDYoKQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tXyNeeWjFs8=;hBctCBREFXoU3Q18GkGGJ/zV3MV
 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
 7Cy5TQ==

Am Donnerstag, dem 21.05.2026 um 12:05 +0200 schrieb Thomas Gleixner:
> On Thu, May 21 2026 at 10:53, Mateusz Guzik wrote:
> > On Thu, May 21, 2026 at 12:52:44AM +0200, Bert Karwatzki wrote:
> > > With these reverts next-20260519 boots 30 times in a row without err=
or, so
> > > it appears that commit dc651e25a6d2 ("fs: RCU-ify filesystems list")=
 causing the
> > > error.
> > >=20
> >=20
> > I think the patch below will do the trick.
> >=20
> > If someone wonders how come the missing unlocks: the original patch ha=
d
> > them in place, but when I was rebasing on top of the RCU-ifing commit =
I
> > figured I'm going to do guard/scoped_guard in there as well. Later it
> > started failing as the compiler did not like goto retry out of a scope=
d
> > guard area and the unlocks did not come back.
> >=20
> > tl;dr there is definitely my bug here and it is most likely *the* bug
>=20
> I was staring at the wrong commit then :)

Sorry, as the bug was rather hard to trigger (with PREEMPT_RT at least) I
wanted to save myself from 100-150 reboot cycles during the bisection.

Bert Karwatzki
