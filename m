Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CA7239E7F
	for <linux-fsdevel@vger.kernel.org>; Sun, 30 Aug 2026 15:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788104325; cv=none; b=MJEsRqVjpiGWcRYanu+/ebFRc1i7/fhPkpvDVNyhkep0mhJbCh0rF/PTwgVWZJQjCvI78Or2e6uyCH+PnafUbrKXLwoDLz2UidhuQECIF07B4lunwIb1TzFuiyxcy+v2p6jo0MLA5cP7jvOZDrdKf9mB1ie2RLO6A/Qhz/iryH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788104325; c=relaxed/simple;
	bh=m6+Ek/PN1wctkJuUny68QYg7Ai+Ffk6R8mB2ne1u+6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s1WyqxoGdrs20ckmpkB3dhV+rjnTHiQXC07UuI4SDl6HI3HNHJUc9NiGP9Q/X89OvEtrDp9MBiXPli6GLfPinEszQrmfyE9xjkoJMWJpigq7tXVOfHcKNzVVQ7csAmdZbTEAZRS1EneeHgDWFsJlrt6jhiC9R8yWKzmcHi5S/2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EvGsCBhp; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EvGsCBhp"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c2544ff970dso400674866b.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 30 Aug 2026 08:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1788104321; x=1788709121; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0Lg4J0njR1Ed9ei5b7HWuRMrIb2Pa5yopcVpnUkqUlM=;
        b=EvGsCBhpTClMtQwDoW1bIlb5qGHmWE+BjClb8YdRvglrB90CQQjZ/xubsLIo5/2H96
         2vdy5IeMz7J33LAywkstIrmzUnWK57gg5HbPJVBhQdDA4O/DLGn2Kl4ZOgPb7EPkh8QA
         ofb+b/E2AfRVcI8gvs2bcQ224v3PeE6Rdv0Co=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788104321; x=1788709121;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0Lg4J0njR1Ed9ei5b7HWuRMrIb2Pa5yopcVpnUkqUlM=;
        b=ZISjCmQan90P3QI8d31dExEB3/TIlErrQZ9yT6erVlCNp4PYMjsQTOVQJaZWrUkMYN
         whobxnIUQc7wcR9oDJK8YZDRtmsb0PhlkZfZ0Yk35TXj1WJv8gVCh+7OeLD2W86Lx6H2
         bo7UFpUSwZIPCOl3+U7yNCD/WqGgaL6ADDaHtmV4/0nr+7Eb2YULqgdBfX8GRzpEKu3K
         kls6uJ+DjPGXGvqqJsmNdaKiAtwASfy11payhstq/o1JJfAFAuSN13OPwOyJnvr1qzdF
         4RF5k+Rgraj7VYoRIKvCY+8S2WoCkdoidr8yYprYPny8ejQeT0gYmCJETxzw+plLMT/S
         JhUA==
X-Forwarded-Encrypted: i=1; AHgh+Rq+Q5iGj3So8pI5/L6a42z4vQbmt4ZxjZLo0ww1n/u+E9X8u2cNMe9UbzSPqdZrcLctFiB4oHiyUzHwRal3@vger.kernel.org
X-Gm-Message-State: AFuF++kjFaMgq+FylWiuoRnYr7H6lk80rujizcUU0R3/WVum3mV2rMfQ
	1ycWNnDbYDx33YlUSoqtOg60UIEiFesNUTtW54hTCL0R5xxEnhcH5ZX3rChMS3pCZlOrlHHRqL2
	ekLZ5br8=
X-Gm-Gg: AR+sD10MDb63+i4hdIaX0ladHMoMeAGJoU1ZDnY/CH/Ow8hipWMImRfktN7cvhNSJxA
	k1IIRH7dOcv167mt5d3L1nzlEvssfUuEFYTr7Yp1NOZBXSUG95vjfA7I9llB+mlzvfIPf6nS/l8
	5NslxM1XNLMSu06RthAn1lbfdbWthyelSh+H8n7zfeqK/Y9Se3ykjS0JSTjVLUe81x1nmhGF5Mh
	1wE5pgCnIOq27KyrnEgI2EuD9G8ZsTbxjjOs2WbOGwn3WXJYSqd79Rcd0kzJgbMfgMIS2PvKRZL
	M+DTA5csVtcKhEkibezL1s4Ucp689umHZWe0r9ketuhbe2DFGjNuKaRNszlkcrxQ2O/dWbU1u56
	oKNVMZqKpo6mxmupd9FWqvQ7Cv3YeTyajyogmWqBqw17wRaXtrFBJwcT6iIXx4tF2U9Kxci9JWr
	+0g075nmas0Sqo+q7514Tbu5NQAkRnIF9aFRzgdqCujfi/KSMrU+q7iIuGSGQ/hsvrdvwRMhh5l
	rwnuC3Ri39iaF61oFww3KVIH6ZzaCkrp1yzgv7aRwyOH+pk
X-Received: by 2002:a17:907:3c84:b0:c25:541:fd3a with SMTP id a640c23a62f3a-c2556c2f178mr1361042966b.7.1788104320942;
        Sun, 30 Aug 2026 08:38:40 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c255ee2872dsm322865466b.15.2026.08.30.08.38.40
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Aug 2026 08:38:40 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c2544ff970dso400673866b.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 30 Aug 2026 08:38:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpvYgezvOuepZqRa8gfcxpBkgnkrikJ9cyZWLAWRyt/bkPcuMlkCaOEfc+n4QSMWhkrCngaopEVUGwsiLta@vger.kernel.org
X-Received: by 2002:a17:907:6d24:b0:c25:4cff:5d01 with SMTP id
 a640c23a62f3a-c25571b1b5amr1265164666b.18.1788104320046; Sun, 30 Aug 2026
 08:38:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wjUmLrJd4KM4xvJHUN4P0r8oSu5LyvG4JipnhxizBrE9Q@mail.gmail.com>
 <cover.1788018958.git.legion@kernel.org>
In-Reply-To: <cover.1788018958.git.legion@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 30 Aug 2026 08:38:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=whswMNv4Cdjb8Wz9kXOVzvMVuJEgrCUD4Q_c8-Vb7Y4yA@mail.gmail.com>
X-Gm-Features: AcwNN1Vwzq543nI2mh708cBhUlSRpApbG4s3sO2SbH8vefWOqxWCXiyIIN7mRF4
Message-ID: <CAHk-=whswMNv4Cdjb8Wz9kXOVzvMVuJEgrCUD4Q_c8-Vb7Y4yA@mail.gmail.com>
Subject: Re: [RFC PATCH v1 17/30] sysctl: net: use sysctl_field in SCTP sysctls
To: Alexey Gladkov <legion@kernel.org>
Cc: "Eric W . Biederman" <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
	Joel Granados <joel.granados@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 29 Aug 2026 at 09:15, Alexey Gladkov <legion@kernel.org> wrote:
>
> Does this look better for you, or should I just stop?

This certainly looks a lot less disruptive, and seems to allow
subsystems to migrate to the new model incrementally.

The conversion patches for ipc and mpls looked sane to me. I imagine
the other various cases would be similar. So I don't see any huge
issues here - obviously the affected subsystem maintainers may have
some (I suspect mainly networking), but the whole "avoid having to
copying the tables" is certainly a worthy goal.

            Linus
