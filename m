Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.122
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794563585;
	b=SZuF+cOu4Mc7sgQW2BbddCzUe9Pzai/GFecTJuz5+5Zds3cWRjcDe6IXnTptL1jLixwm
	 1j6fytr1NVo4pGSBeOSwt0u/h57t0B6md/7+cEdXmWmsAZCwliH+oHwxLPr/qQlZ2Cbsl
	 CmiB0KTMl+osyjjtf4chYkjL6xpjVY68A4tvhDlBP0Rbl/duAt3rUNY3T1x5rsvLhUsaU
	 JQtl6cEu/+BoWGGlwmG6nJHHp2NtBZVxLwo2t8vCZFGQHdLWNtB7CFfCKWUjG80M7ONvJ
	 bZxUhGE2uJlknpHSyajSMM6lMNAAydS5rVfTxEU3qQ+lveUhW7VdvMXzTjdRROXWhTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794563585;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CdowJsXk/55EEpEsAWxQxcRytgso60wJrBMLIWLRJ3s=;
	b=jUkNypKGYf6M0Lp85SMF3orZMLMYTWSE+YRbyaqqneIi4qr8CCr0wy1jCPyaYg2M+Szh
	 BYMXopB6eTkvaJ+9UyxAugEsCOhMgweMKHhpcKGlMDFX+mRp1qc9UBWCbTuStuY6Hxach
	 Gwh2HgCTft9wt2qvyOdlMTNwE0Ddn6oqVqcSR4qAlsBVrpTT26wuP8cRu+f89U6j6XOHy
	 S1mZnFqNgkf3KSvXoUrMijaK8qpwUFAMa5m1avTxaSJM01Q6/DBsHwQS6MSeqg9JHdcRQ
	 BdZGKBde7Egst7lLlzt2l7cgbOwepGkIAYeIRU3VbwTh4delyEPl/uAdaYKZMu3bi/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=mVjfUS8N;
	arc=none smtp.remote-ip=91.218.175.122
Received: from mta0.migadu.com (out-122.mta0.migadu.com [91.218.175.122])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FAC606A321
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 09:53:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3FAC606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=mVjfUS8N
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=CdowJsXk/55EEpEsAWxQxcRytgso60wJrBMLIWLRJ3s=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794563582; v=1; x=1795168382;
 b=mVjfUS8NmV4pon9WzY71EIZ6BbrEYYF61PwHr2Z6qhbQL1+EHI0smpPWGm4wF5/hwepLIN5m
 MY0+/Wevs0pqqBfLJXq9AjpNkfVDwTSKmiluDzdH5TxGzgDczejpLl4FUKt2TX02w8DK22lTTIE
 Vf7XjrJkUp2zp8tleviGwutc=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 7be960e5f0abbd69;
	Fri, 13 Nov 2026 09:53:02 +0000
X-Mizu-Trace-ID: 7be960e5f0abbd69
X-Migadu-Flow: FLOW_OUT
From: Fuad Tabba <fuad.tabba@linux.dev>
To: gregkh@linuxfoundation.org,
	ilpo.jarvinen@linux.intel.com
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] fs/nls: Add codepage 720 (Arabic)
Date: Fri, 13 Nov 2026 09:52:57 +0000
Message-ID: <20261113095257.2034926-1-fuad.tabba@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <87ld72f9rf.fsf@mail.parknet.co.jp>
References: <20261108200141.383158-1-fuad.tabba@linux.dev> <20261108200141.383158-2-fuad.tabba@linux.dev> <87ld72f9rf.fsf@mail.parknet.co.jp>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greg, Ilpo,

On Mon, 09 Nov 2026 12:51:32 +0000, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> wrote:

[...]

> Looks good. However, maybe no maintainer in this area, so I'm not sure
> who handle...

fs/nls doesn't have a maintainer, and Ilpo took the last fixes there.
Would either of you be able to pick up this series? It adds the Arabic
code pages CP720 and CP1256.

Cheers,
/fuad
