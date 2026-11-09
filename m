Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794243155;
	b=pLpgfHQ/3vi8sALkdaTRHWc4mabUibjINXBFE3vQrx1mlntyNEZ6qpd6OBrpGI59yWEW
	 od3jKjGP1qIecuUen0VtLXFkoFRwxIJk6sqmL+mqGr0l5T3cTCL+IItVbBvmu/eoOUaNN
	 ZWuWyOJ7ZrDXkxSe1qacwzMl+yPYhXDE4ZuGtskuRHGKMkI9GQ2NftiqeEaOgp0UnF8Sp
	 mxC03b3UEOVRej/x/4u/QTXebKmNeSFNtOqX/wBHrHsaBEysIK9oTbWUlpaWufdSFL5Rg
	 UqFzof6h9L7ZEGyjcXbJNOwBioGQuytY2XTM9tra04ErUZrAtSkU8BLCEzgu7zf9W4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794243155;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=RXXU/zrEl8TcSV2xj8OBdFZs1lPljfbXu/prQveYVIU=;
	b=fmLA/ZrTyvcZX/+J7COBwiitY/hCiGKEZHyUOAbLN5Au/AzovaRShuOpKPjBP/S3LH3c
	 BQLsSg6eTUfeWTRx4gzaSlwJotQz8Vg9plzivEhrKP/Zk6ql8K/85MZembbj4ecW8zVrZ
	 UUu3Krcg5ndQYVFm/jR0YB6Vv3pl59QwwBC7lkThk5Wm0dmO/aYXMeiy97wvNgTPTtWoR
	 FsfUVOR9+DuWfgq3Rs4tkSqLCj/3clzUgRNmcriyL+XqNdCMPuLz0dFxHeHhhDMkd4rKh
	 TQkm0sERFnZApVT7iCXI+XESNYFLXiMzMABL5FyaY4YG2uhA5XYto0lmkzuzTrml1gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=NKjhmzlQ;
	arc=none smtp.remote-ip=209.85.218.49
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E717960A2605
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Nov 2026 16:52:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E717960A2605
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=NKjhmzlQ
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c4203bbb1e9so153472566b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Nov 2026 08:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1794243152; x=1794847952; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RXXU/zrEl8TcSV2xj8OBdFZs1lPljfbXu/prQveYVIU=;
        b=NKjhmzlQehF87HU8DVv85zqtQy/Q+0O5+AqDcdN91QHmGxhT5zMfiFuoYCzO6kROfI
         haU6g3YF1S9QtQUw1A4eR2r/i7+ejzC8BdSBu2+NTK1dA9tc4KaPPB8+BwAoWFEwjdvR
         9jlGSMQN7/6ov7Mc+gwpIcxtgwhrB5s+GVxsY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794243152; x=1794847952;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RXXU/zrEl8TcSV2xj8OBdFZs1lPljfbXu/prQveYVIU=;
        b=tPS7lnjV7zzJsSZhZj0QWNXLsxvXPkwv5ObA5zu6hTXTCeYfkrgg0efLrB77Hbb9bt
         w/BFkSyrMLktUH/r7wPYQZKwLNPrci0DTfMoKPiYhJTtk6hbax4yBhP2eMxkUx1LJf7n
         +yIBqcS2gwk5DEqBzfMug1cKgxvCQm48vF9GVQaKpZXMT4nfk4poDNfmqLTJX6PaiASz
         N3XwJpqawh5lfzkXBg6u2iLRgY3FqFr4o1J3c0UFBAOt/BIiuIYAsNsw6QuttnwrkakL
         IKdxmHbNQk88OKHLb1JgYsYoSWzFGXfzsuGYAEPzTz+jI9O8MY8tkFu311vfVEI3W9yH
         PIEw==
X-Forwarded-Encrypted: i=1; AL+hErH09lTuH1lx3DufxlTbzqi2bg3NxRrsLpqaLrYXUB4s8V6ULQq21V7gNTkJg2O4gjQ5GxKGPMVfeVc2l221@vger.kernel.org
X-Gm-Message-State: APuU4Z85eSHSHIzXxDWJ1KcMKvcOqNMvyw1asT6I88Wh8THXRStYfaFo
	k7czSa0R4BewPFP3Y38KeHyEO8Q5nlPdWf+XGR/UU0STo/Cs8Z46xb1tFnkhYbgsrTMtn7w6ciK
	McxqaOml2xg==
X-Gm-Gg: AYBFou1UqG+Vyhkr3CBJgmaqGvQa3JJTbqF8Vehj5roD0r1hYv5HR4TTq6EcqshrDiZ
	ZbKiU7xXbwV2/52ZqJfX5QWk6r2z8daWCBK/iMxVQiCv5K+PeJlhGbGcAuP8BXmbZROgnOZaVPv
	T8HeVyt1HDMeNpLwPHNA8vaq1MlOmJgBkboSKINED6RcohNHV2sHE3XJNqSC6P83a5xvyCkGfYT
	7UEi2EilafgABtfoRSNuld2m4hQmXkwKSk/LOYitveGN1kbphz3teQmTnB22fK3DeI4wjNuoQ8z
	ZmUC4FA9iS+aR2psu93qfxfZJu+NNXuK6Q1a/IQRfOIDb/bCyqF5UtMj6TuN/k45F1V+YXRhhTp
	IN1tYshz90IX0u1fHRXcafEytxw+rDkGMNjU1/GMNqCpfwY042aTd2YgA7IgwHVKSdc7t42W3Mb
	oNpFI771JRR8fxTw+/7j3KjVdSsmJs+/vPNg8lYYCWmw0vUaIl/SiWvStmGUSNrWMdSCS7F+d2A
	f0Yewp+g3tKhJR1vzVaGkTZCBNDhCC37zUQizg+RJD0yiQMOjUzHso/O6QF5MxEUttfwVixJ8vT
	IU/EnQEB8EDNeB/jRSdI35gYI7LGhwIcDpOoLCSKFYCoB/gfuml/y1Py96VFqQVmtZyOrZlgz6R
	DEA==
X-Received: by 2002:a17:907:d8e:b0:c32:110d:682f with SMTP id a640c23a62f3a-c4d6db1ee0cmr360585766b.18.1794243152247;
        Mon, 09 Nov 2026 08:52:32 -0800 (PST)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d69f948c8sm187353166b.17.2026.11.09.08.52.32
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 08:52:32 -0800 (PST)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6b2237b596cso2505372a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Nov 2026 08:52:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHmYf1rE0yHl/RwS3cPegMy3jZCP4NUAE1fNB7ZJuedEweKtOTG23JzcZ+Uq5z0Gy10KfZTRYcjAl7G26FM@vger.kernel.org
X-Received: by 2002:a17:907:d23:b0:c4d:4ce1:e2b7 with SMTP id
 a640c23a62f3a-c4d6db81591mr423916266b.34.1794241699892; Mon, 09 Nov 2026
 08:28:19 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104130118.2507513-1-kas@kernel.org> <20261104130118.2507513-4-kas@kernel.org>
 <f21433af-afc6-4a8f-8d2d-3a377cd3bd6e@kernel.org>
In-Reply-To: <f21433af-afc6-4a8f-8d2d-3a377cd3bd6e@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 9 Nov 2026 08:28:03 -0800
X-Gmail-Original-Message-ID: <CAHk-=whn=xc9J3qApHWRGTaBpwVRtGbvJ0LURGF=dqC9B3swUw@mail.gmail.com>
X-Gm-Features: AclHuK-PHrKxDKHmHgqeqU9KXvHFHYbJyk2lhNjfjS1J1daidL5w5IKJYicIRls
Message-ID: <CAHk-=whn=xc9J3qApHWRGTaBpwVRtGbvJ0LURGF=dqC9B3swUw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 03/18] fuse: don't move a folio with PG_rcu_free
 into a fuse file
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "Kiryl Shutsemau (Meta)" <kas@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Jan Kara <jack@suse.cz>, Hugh Dickins <hughd@google.com>, 
	Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Harry Yoo <harry@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, Miaohe Lin <linmiaohe@huawei.com>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Oscar Salvador <osalvador@suse.de>, 
	"Liam R. Howlett" <liam@infradead.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <brendan.jackman@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Baoquan He <baoquan.he@linux.dev>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Pedro Falcato <pfalcato@suse.de>, Luis Chamberlain <mcgrof@kernel.org>, 
	Ilya Gladyshev <ilya.gladyshev@linux.dev>, Jaegeuk Kim <jaegeuk@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	fuse-devel@lists.linux.dev, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Nov 2026 at 06:46, David Hildenbrand (Arm) <david@kernel.org> wrote:
>
> Could we get rid of fuse_try_move_folio() entirely?

Please. That would be great.

              Linus
