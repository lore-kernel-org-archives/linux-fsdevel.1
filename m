Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792560657;
	b=Dsw7LjRmDOcdsGXF9ZAF35ysnL+AGuaJyk5SZWn/L1ONk47lIB1Li3B1/hsAkZdoCdgR
	 0Qpb2TjFYmXpT+C0X9edOP5TxpKnwbMauC3GCnoXmwPoQe7mRDQM50z0nHMtaqjPI9U6X
	 Yyyi6Cg4VRpOZR2z9yaXDEyl1wwRMBbFOhF4Fso1zlfHbEpezLhY2PCaNv92NC05OG+Ma
	 G5rysHtD7IB5LtmfUpcMCM95AWXk7pJy54KH7JI8T0ztEF8ZSencVITd2yu/lwlwS7qk7
	 LvZX3nzZjLW3RTTDxMN9Ymw+xHDQKf6o/GJb5OfCZEoi/MPdEc2sS5kCdzzuRoTy/vQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792560657;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Message-ID:In-Reply-To:References:Date:
	 MIME-Version:Content-Type;
	bh=wOxW4z1BbQYP9uEvGV85h66bQb0xJWZvNtv4eVINyQQ=;
	b=K5Qf51J8XP1eH2muVlMhSJwe3F0UEBtQp/MTTD2Y7IAqLUGQH7CMfa0mmblvsTIcqTBp
	 RV4PxQxIVbnxKJvSGXyaIekAEdfPigG5Ut+OsrLIE4h1IKs4s+ZD7/SWsA3yPibg0z+mB
	 qIw4MIe+Dx3VBHgxRlYj46fbJsA/wB+IKz/0eZNC0D8Rv8ItqEfResNVUDzj2BQMJoD62
	 DL/rpAuIqO0dYXV0U6G20m2HiILalScGUCzKOIBBvjIGuQUVkzvs5jOFCN87t2+yJ+sV4
	 R/C3cGiZzl2ABKjaPokFKbbu4SRApFST7z+js34mWFiHeVcmmRthvE83CuCOvKZ+VkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=innovatrics.com;
	spf=pass smtp.mailfrom=innovatrics.com;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98CF606A327
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 05:30:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E98CF606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=innovatrics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=innovatrics.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49d0da752ffso1871855e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2026 22:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=innovatrics.com; s=google; t=1792560650; x=1793165450; darn=vger.kernel.org;
        h=content-type:mime-version:date:references:in-reply-to:message-id
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wOxW4z1BbQYP9uEvGV85h66bQb0xJWZvNtv4eVINyQQ=;
        b=dZG9+Qrbq6r8virMQzN/ZnScSqFL9UpktW2+0+n3rDobwVeYO2vFRf/TLLKIVXBmhF
         Gy8RLB4EpeJSlAY8DjkXHht8NBPQbM5e5fFurkIdO9DfEYRLT1UnIUiVHv5USugAATTU
         SMpXa/vr/CV4YYNC5DI0uYI78q0K+X5Fj4Q/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792560650; x=1793165450;
        h=content-type:mime-version:date:references:in-reply-to:message-id
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wOxW4z1BbQYP9uEvGV85h66bQb0xJWZvNtv4eVINyQQ=;
        b=oX7tetquWcVlXe7YBk/n/UVTxqhlHa2gHHOTSgAsmAiMJnMz2+5smNZCmYCiO2+ExV
         O9AeGuDVAiGVWgnbgISsG41ycr4R1eRF75rv+drWZY3zuEaK3WaFqu3RH926Takyrz/g
         5vQlXHbIlWLbNkwVPV3x5QuD6OAuOeAj7H1jD1BYtWsbesX+GuJhgEksBvPa2EkqEMAB
         J3ZmttRjoF6HpNkIZajxCu4lclRIhFeR5rCmxv3I08EM3HYozfD4T/cb46u7qNPHRosR
         6vDDjUdtbBOXI1+5lz3I/WDtpzEopNPjnDOSuZlvNXck3kcCA9DXZyRt8+nBGa9AP+P7
         dyqQ==
X-Forwarded-Encrypted: i=1; AKwUvBy3weKAaCppLLYs1d5HqhHz+jdISuC34hqSt8Ih0kZuWuH8l4IcjMjUIDJeyntdjlHLw8t6e8FKxx1xTqwn@vger.kernel.org
X-Gm-Message-State: AFq9FYKkeowPffSQLNEb6KxmJ5Wvxrvsd/ks6qS0LPC/fdLDr7S/ZJk4
	09mIC2otft9GXrBgZL79iB3XRo7cHRlPBZAMNwxl3/O33UCfcRw1iAkAzCXLenbJTA==
X-Gm-Gg: AYBFou1/eZ7PvjWc7x1UbUKNMv+PSVaJ+HA0DI6AXZH1M+7Zk7bGJlSck5DGQXWFTkJ
	eaYr0w4TVMRVZlonLD8GFPGR/Ndg19HP3nNu77dk6x0l8b2n06WhAow+VHv7a5bf9s5bLWWMUs/
	3s6JE/iRoQNSbymclSzlEUM3d7nI+W6YVIyse1PdYkcJOWsY0t7t5DINQtzDmIY5Bv2kVtMAQuM
	+wcGDApvURHKGMHpf0X4HzK/2wHNRMZbd/SQu9vkLpF1BsmM3C6sAZKaP3wCwp4Xso9WzahRkRC
	yhIGFkghZURzW/wcMpdq117lyRrwtH4QmyFFA8+cUGNbbR7Q0SQYDCbBgs6TIm7tMtdIitaB0Tg
	shN8qYMAc1iFqypzRMmEfGMKYw5f+ARNPTbGwGNSOKXG/yBXRHR7nRKfJiP0UQ2JsgdifXzzJhw
	2NdrUdmIISPDiBKuFOolTUwoiEI9it1BwNj+PH1550M36KEAsCLIQtswRBhXQOzFLQPGi91pP0i
	b9ouUzE9o4CV0B5msbfCEGhZZzzOrOY0xeSnY+LiiWLQTPINly7kPp06DvgCnkf/ZcLFPLhoO+E
	sjgVPPX6cFHQc1pX6yLYMshi7+3zG3+hJ6Loe5CUlTwxs86FSlsd0hOiGrlADnTN4R3zldC2PKE
	vMiyPjjp9qHer
X-Received: by 2002:a05:600c:4686:b0:4a0:b6:4619 with SMTP id 5b1f17b1804b1-4a1fd72e1e6mr17106685e9.0.1792560650270;
        Tue, 20 Oct 2026 22:30:50 -0700 (PDT)
Received: from [10.11.72.5] (bip-static-148.213-81-147.telecom.sk. [213.81.147.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f8016c93sm85779985e9.5.2026.10.20.22.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 22:30:49 -0700 (PDT)
From: Petr Chmelar <petr.chmelar@innovatrics.com>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>,
    Paulo Alcantara <pc@manguebit.org>,
    Matthew Wilcox <willy@infradead.org>,
    Namjae Jeon <linkinjeon@kernel.org>,
    Marc Dionne <marc.dionne@auristor.com>,
    Stefan Metzmacher <metze@samba.org>,
    Eric Van Hensbergen <ericvh@kernel.org>,
    Dominique Martinet <asmadeus@codewreck.org>,
    Ilya Dryomov <idryomov@gmail.com>,
    netfs@lists.linux.dev,
    linux-afs@lists.infradead.org,
    linux-cifs@vger.kernel.org,
    linux-nfs@vger.kernel.org,
    ceph-devel@vger.kernel.org,
    v9fs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 4/5] cachefiles: Don't rely on backing fs storage map
 for most use cases
Message-ID: <20261021.cachefiles-mainline-confirmed.pchmelar@innovatrics.com>
In-Reply-To: <2648476.1792482342@warthog.procyon.org.uk>
References: <20260910220242.2165023-1-dhowells@redhat.com>
 <20260910220242.2165023-5-dhowells@redhat.com>
 <20261011.cachefiles-partial-zeros.pchmelar@innovatrics.com>
 <1655268.1791878098@warthog.procyon.org.uk>
 <20261013.cachefiles-partial-zeros-trace.pchmelar@innovatrics.com>
 <1995693.1791971125@warthog.procyon.org.uk>
 <2648476.1792482342@warthog.procyon.org.uk>
Date: Wed, 21 Oct 2026 05:30:48 +0000
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"

David Howells <dhowells@redhat.com> wrote:

> Note that these patches are now upstream with this change incorporated.

Thanks, David, and sorry for the slow reply to your question about
the fix - I was on vacation.

I've now tested mainline (72a16bcff2) with the same reproducers as in
my earlier mail, and it fixes the problem.  All 4096 blocks read back
correctly on both full reads, and the reads were served from the
cache:

 - 9p, cache=fscache: 0 wrong blocks (936 on 13e340e397).
 - NFSv4.2 loopback with fsc: 0 wrong blocks (817 on 9f8b64f66),
   also after a server-side rewrite of half the file and after
   truncating and regrowing it through the mount.

Thanks again for the quick fix.

Petr
