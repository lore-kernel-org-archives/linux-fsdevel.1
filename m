Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793436993;
	b=ubUBxFZsQpwCpg8PZ6rteGN4NAW4oxQWuzUg595hsb5W4GoqoRlevY+b3hW5ttQaY5YX
	 71fDnyiE+8UjDeIbKdskNS2ekASoTOh6GwKmi3eGU56J9LbrZGxNjuYS+6+16i4f8cJB/
	 q00/bFCAhrVlYeEt0kSczDzqSgdEF4tQOjKJO7aIrNaU70ncXcuptYrELSHw7Xb+h0TCl
	 KMFV6+YRCrFnajsgiN5ooTqe8uOrP6+xRlhTmcMOnfEjAn93nMVMkB+yua6bZ/CgGXzwf
	 co2HpzkQCp7Jb+RhlxHoEmVkUMnE+GeK01rgYnjVNj9OnbSbVWrCIeE/9wcpI/LwaHA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793436993;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Content-Type;
	bh=gTx394sikhqmmuQLs1UOGGZh1cBtivYg1IDNeqBRTrY=;
	b=DGlCRxc6FjVTWsvb781WEM5I8/2AmbgP0JtMCBsI2rqfL/Pr1EyuI8FHBw1RDWWJjofj
	 VQSWs4CJ8gJU2iFEjQpBf6zY9sRgoshA0KFw9+UUROJzObvrxJ0a5bgqAwXzEsj/GOTH1
	 86r+IeoRFb1yBnTsy2sIQEwudwLh7dCPj4yVoBDcyUtgep2BJDRxUSuswI90lPNwth/jQ
	 ZqsV5u8lcCMuAf92a4qYxzoviecH+OYqegKo6BetSCKENvg9Vaik/9VKaYoRucF1nqVok
	 Cr0fZ4qYTVYcrKqt4O4U88e5r3h/pqT5vkjIlTXXS1mjEdQyfjyHXF8m8g6K3xrn9oA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DeHOV9sO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.49
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2EA606A31C
	for <linux-fsdevel@vger.kernel.org>; Sat, 31 Oct 2026 08:56:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC2EA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DeHOV9sO
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-6b19e291cc6so1415982eaf.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 31 Oct 2026 01:56:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793436992; cv=none;
        d=google.com; s=arc-20260327;
        b=NGkTDkHVRCqbTdjhCBdbKc+2PLjqqFnAJvvtPc0/MiINbW6EOGjoD+VW3skMQX8h4S
         +b/UISrnqw2HemDK+hetqIltKCyv0yhIABfNDINBDjKpv5EPwG97ZklJccHH/e1EfVz0
         RFwGjBEVqg9xZDg+KfC0pD4h1osLqjZG/64ilvN4CTOUnElICTbfNpB0MGkFqcJl5Ruh
         jxp/m0BXyue+nCBSpEGbs2d8w/Fc3G4+CY+KD4vf+eLTiAY7Mzmp0BJLX09lUHzoPrwI
         PHfGxt8+8nRLinMIGw4PzwCSkwBxjMRhNIMfL0dbEseYTsQW7uh8UZcIRSIGMVILjTWo
         ZTEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=gTx394sikhqmmuQLs1UOGGZh1cBtivYg1IDNeqBRTrY=;
        fh=pJL6PDt/X4u7OCsGc0jQeChqGmVt+NCOJcrUAG63E3E=;
        b=T8JsiQmhn8wI8UFXVwvnYM6MX701X1+B8TcWud9t9Pnjh3E88sy5nTe/nZUWhE+BWg
         atWZPM9llYq2TZch8CPCaJlFGeIttNB0PW49acYhKhj5GNjmFpE/L4aG70hQCtFUs34K
         YQypXwvE/myZmfFhzEaDNC5o+MKNxtEL+aKCyjeBuRib3ngpV1DzJk5zjsl9LyUlJ13m
         AyFIuikBR0g84OD6vNWIGAwI1FQ/E0mlu2GdSpAD7qTrwRJePlvx72vTG5akJpnrYDxh
         kVCH8yupHxNqDh3tdIQLkKu77za0TYzZGjm1E0vyGAo/qXoZzKHpSRxivAY2xGkeypZ4
         neSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793436992; x=1794041792; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=gTx394sikhqmmuQLs1UOGGZh1cBtivYg1IDNeqBRTrY=;
        b=DeHOV9sOnWxQmpnlrNyp0tXMPco0LV4SJ/AXWNixEZ3xqyK83zZYxh71297jo1bXIA
         GkyHG8oGg3id6m/ZsYERqxpqf8ZSEdEE1TKaHQmC9+c3XWdeOM9ziyOMp5L9v7nZpbBH
         NQypkLnHRHT1s8WpLR9FU/tksxeiXUxAlgIUO7vDyn9Rbdn+1x5niceNr7kIH8TPHJNV
         80IAux0k1j9wI4apSOAocHtICKfg0SG8DwCvfZZUUz1M5v3exnre3Zck5w15Rj6jhKWA
         yjoRE0skUBTHiZm7iZaZ2eomX5S+Yl93ZNqXdRZp1eAmqtFvwYLjrEYyeGA7pCY7dieV
         JpwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793436992; x=1794041792;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gTx394sikhqmmuQLs1UOGGZh1cBtivYg1IDNeqBRTrY=;
        b=T93zKwtKTlFChOKpxa9vIk5l3GbAi7nrRBfjC/SePPJ2eSEdA+LHook/Xq20/5HplF
         rVeYaMDAIEYqeyBwj1OXvmLA7F8vhyT3QP+lbFjaN16UuyILYmminXgRXYrgiAkSKzSh
         ccPY4p7A7a26/tPPz7Qz809X0VuM2EJZc9CKc0zQuAWAA2dXbuGXeR4IpsPBLKrsf7VK
         dHOdVkRDqq5u/KXJ2oOC27EOZiW1gR+gD87PbPyPczSLHRr1Fm3GaRDW0mqcCuxNUpWt
         oHpIw95mGTZ9g5TUOeAGlsUKzTBEVJClPk978gD62QfJvp4i7mSa09rYUY68GAA+xilv
         FfdA==
X-Forwarded-Encrypted: i=1; AKwUvBxzsRgfqQSgRAcG2+JMf4AYHDjiJGB224flG9lcQXUlcFRnkoD6FfaA8d4Yc95ZvYeZQoU/Y66onxnMDh6N@vger.kernel.org
X-Gm-Message-State: AFq9FYJEh+oQ2jpTwusQ8xQ0yoi8BOs90dXBIHBB6xMJ/1gc0Y2SNyfx
	SSgkFQDiA+jz/cFwb3Kpmfr00smaFtTw2sEtwwL4zkkPrgQoJ19GEeyKX7W5KvVT6GITV/3CWA2
	1jfsHhHe/nboUdHYMhBfkQht6bJvqSjrtDTtp3mQ=
X-Gm-Gg: AYBFou2x7PSv3loG4+X3d4A9cyOBQy6Ihj5IWJWbpcPe7PHLDaSU/Xrs5P8qd35vDbJ
	dDkC/TcSSazyNo+1YnT4fXe1GYY/y+cg16Wrxx72HryrOLDUFZnO1GH1xfMPkyGqnt9Ai+2vptz
	jwrmUiwlUP92OylQG3dmZrBnfZaLjoJjc2pPv9co+FsdKH5n7RT+xlFWyqXgAzSl2pvREdPwBzj
	ocRPA4B5viYpVp8dX87yfNevcNPe3i13FB0jCMOB8KuvSBJ8ztGcH4lneUSCm6krQXRvJj7ZbfV
	i+YyxFAmXtlHbwNgTf2e1yeSIlH55nDQdEw9XsCS68alvs2VXc4Dw5sS83f9Z9QP7Bxf5u1LLFQ
	BXWxzEEh8RCRnIA3XxIHGnCaOqPeeUV+m3mF041B/bsGdDo2xVmnJI2L+3Hgx1ltAIYC7B5dWBF
	aLVa6vI3VTsTqFUw==
X-Received: by 2002:a05:6820:828:b0:6d8:28f1:140e with SMTP id
 006d021491bc7-714f290f510mr2610377eaf.24.1793436991830; Sat, 31 Oct 2026
 01:56:31 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: David Kahurani <k.kahurani@gmail.com>
Date: Sat, 31 Oct 2026 11:58:14 +0300
X-Gm-Features: AclHuK9U09vFG1uxdVZyISvZBb-LYUaWKM7hNZBKSGvcoPSG7k3gSFLXT4t5Gac
Message-ID: <CAAZOf25+GY9t4vrZQzi3UdgmeeqqXt8833sWy2C8oEZ2fztRTA@mail.gmail.com>
Subject: cells: a container as one kernel object
To: Jeremy Bingham <jbingham@gmail.com>, linux-fsdevel@vger.kernel.org, 
	"andrew@amutable.com" <andrew@amutable.com>, James.Bottomley@hansenpartnership.com, 
	"josef@toxicpanda.com" <josef@toxicpanda.com>, brauner@kernel.org
Content-Type: text/plain; charset="UTF-8"

Replying to: 1.
https://lwn.net/ml/all/20261026-cells-rfc-v2-b41d7e0c95a3@toxicpanda.com/

"

--------------------

The pitch
---------

A container isn't a thing in the kernel. It's eight kinds of namespace,
a cgroup, a seccomp filter and a pile of conventions that the runtime
holds together. The kernel can't name it, can't kill it in one go, and
can't tell you what's in it. Privilege inside of it hangs off of uids
and user namespaces, and a task can be half way between two sets of
namespaces at any given moment, which is where a depressing number of
our bugs come from.

A cell is a container as one object. A task is born in a cell and never
leaves it, and no existing task can move into one, so there is no
setns() and no unshare(). You build it from the outside by filling named
slots from file descriptors you already hold, you seal it, and then you
spawn tasks into it, at any point while it's running and not just to get
it going. Holding the cellfd is the authority to do all of that, there
is no uid or capability check on it, and making one takes no privilege.
The cell lives exactly as long as somebody holds the cellfd, when the
last one goes the cell is killed.

Whatever a cell has, somebody put there. The mount tree is built from
scratch by the builder, nothing in it hides anything, nothing propagates
into it and the cell can't mount. The network is set up by the builder
and the cell can't configure it. A new task starts with no mm and no
files, so what it has is what you gave it. Say nothing about the network
and there is none, it doesn't fall back to the host's.

A few rules fall out of wanting the boundary to actually mean something.
The kernel allocates the kuids for a cell out of a reserved window, the
builder never names one, and those ids can never be stored on a
filesystem the cell doesn't own. A uid means nothing across cells, not
an equal one and not 0. Files impart no privilege, every task has
no_new_privs, and set-id bits get dropped on anything a cell creates,
chmods or opens for writing. Unix sockets carry bytes between cells and
nothing else, no SCM_RIGHTS and no peer credentials.

------------

"

Your description of a container is rather lacking. What you described
there is not my understanding of what a container is.

A container is grouped set of system resources. It is purely virtual
and doesn't exist as an object by itself.

I'm not knowledgable enough so I will not proceed to criticize your
design document.
