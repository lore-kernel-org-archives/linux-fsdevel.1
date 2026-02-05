Received: from mail.venturex.pl (mail.venturex.pl [141.95.86.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E3C31ED7D
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Feb 2026 08:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.95.86.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770280599; cv=none; b=QFIS4aoyU5kixKWkpVo7xb9DfBNFyoGBe8KzykbG0DcC0QqcqK6cj3EHlKPLfkJR7p0f7LRzv/Ph4aNf+WFODTYNjzDT6BKYGnr76IJwCpwDCDnfXo5uYZooqT16Bap84ZJiXSBB9Gcn+SD+YtX5pBBLQ1f10gQmIKDW1JAaULY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770280599; c=relaxed/simple;
	bh=86VIaF2unP4vg5OpX+J8tHPXWoQ8hu3kSDMcmnIkxvQ=;
	h=Message-ID:Date:From:To:Subject:MIME-Version:Content-Type; b=s4O21TqdfH10tEMQQVeBb9pP5F2HHD6iwUh/FJmNVfXPnRTQdqljd+tK4tsh049bushu9+pGN+xIUoNRCIFLbdGJdWlbAALdXOM/ud7okhPnWjgLycSnoITyLrZUtpWNOmC3U+fh9/MvFnp/LzxxAVKOZ3VG9ygR1Vqhjl3ygdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=venturex.pl; spf=pass smtp.mailfrom=venturex.pl; dkim=pass (2048-bit key) header.d=venturex.pl header.i=@venturex.pl header.b=Ql2O1LKp; arc=none smtp.client-ip=141.95.86.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=venturex.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=venturex.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=venturex.pl header.i=@venturex.pl header.b="Ql2O1LKp"
Received: by mail.venturex.pl (Postfix, from userid 1002)
	id 6FBDB243E3; Thu,  5 Feb 2026 09:36:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=venturex.pl; s=mail;
	t=1770280597; bh=86VIaF2unP4vg5OpX+J8tHPXWoQ8hu3kSDMcmnIkxvQ=;
	h=Date:From:To:Subject:From;
	b=Ql2O1LKp7sNtfnwtpNAoTEvwvWEtKRV4qd1Z9O+spoWmFOc4ss4aHV6ODpilx/VRV
	 XEBt6MjxN19o6aJcje5//f+7+2W8V03U1hHldKuVyg8oMVhvSo8Ofy/Ihd3vybNrS1
	 YHVSdfZfxt/uLBUhYNNvYTR45bYYsdORb3TODZgLddUSbvVw8aDMU+B7Lv9QvBhxX0
	 Pn+z13t2MJFVs9D93VATvYg6cw+E0hueh2pdY9EZWNyUhf7VLLPUPVwk222m9/mfhN
	 wqAn5c1C1ar9GakkLRMgi6Gg+Gg181qGwEt5hbBjzew+xPoGfWitI7O2ToBTxa0G7j
	 DGBnmkPb2aU2Q==
Received: by mail.venturex.pl for <linux-fsdevel@vger.kernel.org>; Thu,  5 Feb 2026 08:35:40 GMT
Message-ID: <20260205084500-0.1.ci.2jefs.0.hxf2zoiqik@venturex.pl>
Date: Thu,  5 Feb 2026 08:35:40 GMT
From: =?UTF-8?Q?"Miko=C5=82aj_Rak"?= <mikolaj.rak@venturex.pl>
To: <linux-fsdevel@vger.kernel.org>
Subject: Fundacja Rodzina a optymalizacja podatkowa 
X-Mailer: mail.venturex.pl
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Szanowni Pa=C5=84stwo,

czy byliby Pa=C5=84stwo zainteresowani rozmow=C4=85 o mo=C5=BCliwych rozw=
i=C4=85zaniach dla swojej firmy i rodziny?

Nowelizacja ustawy o Fundacjach Rodzinnych otwiera przed przedsi=C4=99bio=
rcami zupe=C5=82nie nowe mo=C5=BCliwo=C5=9Bci ochrony maj=C4=85tku i plan=
owania sukcesji. Fundacja Rodzinna pozwala oddzieli=C4=87 aktywa od ryzyk=
 biznesowych, prawnych i podatkowych, a jednocze=C5=9Bnie zachowa=C4=87 k=
ontrol=C4=99 nad swoim maj=C4=85tkiem i zadba=C4=87 o jego trwa=C5=82o=C5=
=9B=C4=87 dla kolejnych pokole=C5=84.

Co istotne, po up=C5=82ywie 10 lat od wniesienia aktyw=C3=B3w do fundacji=
, roszczenia o zachowek przestaj=C4=85 obowi=C4=85zywa=C4=87. Ustawodawca=
 przewidzia=C5=82 r=C3=B3wnie=C5=BC liczne zwolnienia podatkowe obejmuj=C4=
=85ce m.in. dochody z dzia=C5=82alno=C5=9Bci gospodarczej czy wynajem nie=
ruchomo=C5=9Bci.

B=C4=99d=C4=99 wdzi=C4=99czny za informacj=C4=99, czy chcieliby Pa=C5=84s=
two pozna=C4=87 mo=C5=BCliwo=C5=9B=C4=87 stworzenia Fundacji Rodzinnej?


Pozdrawiam
Miko=C5=82aj Rak
