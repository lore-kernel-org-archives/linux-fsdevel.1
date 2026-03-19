Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1FC126BF1
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Mar 2026 01:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773883669; cv=pass; b=JxquDNbHQmmKkK6CAvNE5NLnPF3w7QcIYivQ+lmYExAM2GXgH7ms83oxFjBmFjlzWRRuKUP2UJTJv6gRFmGrBPs/76dR0KVdo+K424ocAoilqA7xb0ec8W9pa9mKn6AmkK9aCgL1VwoDqeTvLeq31XVPI8JrxOfLOozfADP+jX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773883669; c=relaxed/simple;
	bh=ohk3ja03TZovVh3o/E21CKH0GvV4S6rDmtkQbbbW0TI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nWvivFDtNZnrpepvCbbgnWCQKLrS3vwrzGH4B0IKHqO5vY/LqW8MQ4BsG6eG8nCwGPO/8oIABRC7vzMkXrq557JwJj2Ohtgxe32eKxhuQq3mqlqWmQRe8zPXbSxuTmbGTlOIgiwwNokcdBkxhcaoZsaNh+QTX1GfSgeBsjAjI1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VqdTBsmK; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VqdTBsmK"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-64ad79dfb6eso840023d50.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Mar 2026 18:27:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773883667; cv=none;
        d=google.com; s=arc-20240605;
        b=VRfiKmG3wcqDKGtCJNgZ1hwcbOieNjCS15dEuGwLHQubujA1AbjU3tLq1u2yfORo7m
         sjmosmGIPQpZIobRY/LgQE2s1/wY110Pd+/POdFuo23Rm0FAgVx81K1UEoZ/QvTff8xu
         95B3iB2eOrciILYo+51hi1rDWY3VT/QcBL1mevui37xBdnpEY9ehScId5OFkVUyMgSW5
         vM6LdYxuDxI7rqFlkwyNaAOmdInbRJh/prfkxYJ2fvS0Aon9G2baY2iA7Hhf6ntASMOU
         o2JnZlpRcHc/qnUWJvdNz0a1TJ3ify+vweQBgK8xdW0sHG1+ihG2D5FmfEQ6a3h3KN0v
         z4KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ohk3ja03TZovVh3o/E21CKH0GvV4S6rDmtkQbbbW0TI=;
        fh=HqTp9XUDS//c3S9PQJrwbFEiQYpqXhdjuiiT+uem1wY=;
        b=Ei9IXCXazf3JG54pzTAWLFYI6OOw+q127wPUEvIYLURN+w5UaVgzmqdDONWAoRWfv6
         lGg9LeIDGxrKvbL/3reBqJ++30eLjopjCZpQ79h7jsEtBX1GPm7FHhAKd2QQtw2OWBC1
         lkSWvNPEJKTFi7zBjHTc87CkCvBzN3oDA2edMRNz0+Jk/G1fOX6aujeZZpq6La2E65od
         N1J4vxe4N+TWmPT0mnxd/u3tsK7Ccb1EkZpgaFEqn8BwxKFxkZX/8b1iIdgvvEFXrMeF
         IDC74tfBicj0379KHXeyX+BfX8RgtHYMcN4Q9dLZwYyQno6/xKpqsQJMDMGXZlr2IyST
         LPCw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773883667; x=1774488467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ohk3ja03TZovVh3o/E21CKH0GvV4S6rDmtkQbbbW0TI=;
        b=VqdTBsmKl9oY/+5oUV3taWSAHqXUYFk8vWfm+nmYgFXUCQHWXMNiIsBwJJF85uMKF4
         CNxTVMXheHpEGQmLPBjSKI76knHRe19BGk6YywdfpFVnR521kbLe9p+Wx/2+IeqgoTbQ
         zPMXy1xx/GdGku6ZlbzFqafiSMO/OO8AuG7nEWYIdNIvx4ie0jltnHPHqkKjBg2ttPRU
         SysHPAMq0FatO5G/uIjjUWCy2+mwsPMESyJEEYsY3vNbd5Ilf4GqoIWwzSvLQfJrORxJ
         7dBTqIM9pGhz6Rh1YdGZNRyAQJufR1Xfdpr8NPNc+tvRmVmHVk1wdElEOsZBTqfk/+Xc
         eePg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773883667; x=1774488467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ohk3ja03TZovVh3o/E21CKH0GvV4S6rDmtkQbbbW0TI=;
        b=pKm8ct34yuWaTnTBKoMwR1hrhbUqiTrrTrVfKqNs8tnzEYLJ57PhpNTMUfxFWA4XdA
         S8v3wCjFOm8eKVVpsvReCk8Fns4b7+DEI5BgxVE6MtGt1BI1ZT2MiSNU5lp65xodLJKN
         u5BGjjkAL++Iac6oVBw1VIJZ1IoIwm+V8ZpAYYykLOuwlQPqTDeJ3xFoTKJFeSxLeErz
         EELHYJyghh761+fBL3IDFI9//F2SBcYqWADHWKv1thkkfcvzouoFf8P32coZmN62sfIr
         9PtHq+vvB/P4JYObSlpW/hmevq3ScWnMN8CohnxFdvJY4I5oH+3FA34VLcri+bJ3yHkW
         0eeg==
X-Forwarded-Encrypted: i=1; AJvYcCUknrXEA9vr3YI0Wg0QixV71g4rMniPn5mc5Cym94gSh+1PLimpe0IOzAIfLeqdhUYLBSu3FKOxxhsXIzek@vger.kernel.org
X-Gm-Message-State: AOJu0YwBLAP9ANUoIW9JIA8yerKqLUN00b1id0Z1jGpIvLtiMmslopvz
	nrJqHl6KULDZXXtvq2cGe06QZG7p1Uyk12Tk/E7NP69NFoHfkXzuMLBQlsuw7X3BpgN1BnLi8he
	IWybNVJXDrlmVOcHnGYNIUGE9E1vsACz9lw==
X-Gm-Gg: ATEYQzzfrLw+GtqZvjeGS6mTEqATNZ4Db6HBWFkyzVU1RQiPCBn6JeuWRTgbDalFsT1
	KkX4gdPVf+NdxPCM3VIE4kAr4jfOltB/FOb+Qz9MXNCusNHD/ltWQFptSjgorfWcV84zD+scNr4
	vKI0y9IP3kPL3Z7OqapvPT0Dj/1TNySpmEpTFO5Mw2E7iPNejf9aJDE1KrGWn5ZTF4hM7HJpjIB
	1v7n7J/QrqwFD1Mfk4OOQSAohBFPZxveR0YhjkFVlTLPsYMgzD841kGZBX31yLxAUSumSO1ecJn
	wPaCoK2ZMJY/Ak7PW8VyuDHJAtt6efF99upKo7SBoPNI0Du1RkIkpQTPjFQ4Ridt8wlIIh1e
X-Received: by 2002:a05:690e:38e:b0:64e:890f:bfc9 with SMTP id
 956f58d0204a3-64e915bda13mr4506333d50.53.1773883667185; Wed, 18 Mar 2026
 18:27:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307010302.41547-1-kartikey406@gmail.com> <9924e9d1519afbbce87321988e0f4b95005f6381.camel@ibm.com>
In-Reply-To: <9924e9d1519afbbce87321988e0f4b95005f6381.camel@ibm.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Thu, 19 Mar 2026 06:57:33 +0530
X-Gm-Features: AaiRm515Odjw_n-xUKsLetTzpceht9Rc2YO-8SRGxVrjZsivdp8h7wYGhCZYR2c
Message-ID: <CADhLXY7Cmtm+=_7Bvz2XkvFsPtL4bVVwvuMjHZVj3G6r5aXoTw@mail.gmail.com>
Subject: Re: [PATCH v6] hfsplus: fix uninit-value by validating catalog record size
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>, "frank.li@vivo.com" <frank.li@vivo.com>, 
	"slava@dubeyko.com" <slava@dubeyko.com>, "charmitro@posteo.net" <charmitro@posteo.net>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"syzbot+d80abb5b890d39261e72@syzkaller.appspotmail.com" <syzbot+d80abb5b890d39261e72@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 9, 2026 at 10:49=E2=80=AFPM Viacheslav Dubeyko
<Slava.Dubeyko@ibm.com> wrote:
>
>
> Applied on HFS/HFS+ git tree. Thanks for the nice fix. :)
>

Gentle ping on this patch. Just wanted to know if this is pushed to linux-n=
ext ?

Thanks

Deepanshu
