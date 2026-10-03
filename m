Received: from mail-pj2-f40.google.com (mail-pj2-f40.google.com [74.125.227.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F4C15665C
	for <linux-fsdevel@vger.kernel.org>; Sat,  3 Oct 2026 03:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790998276; cv=none; b=kmQhkBqMHV+cPXL9eY+SswoiGHroHS4CGc3TQMpzcFiOx3yTfix+kEa7SKybRb9+E8FMN98qQZ4dSLg+eDIqT4qfwxqAM4J2OYe5+THoKRhFE9YaKo9e6XoN2pyfhwYEWUiZ6ucdceW7OSROavZTW4Y967FIHi5PIdfz7rl7/jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790998276; c=relaxed/simple;
	bh=97uawHidSB1rYodKjDdjsSlDXIsf2v1irs/NqM+eBxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kvTf31Z6HMXZXG7QvUAk3FazccswFTGRbA03JFDkmZBRr2cLMrPHk73O9qIYoFL82sbUu+1UFQMg1p8Mkhp4A5f1ZxZGAnWXByx3Zwv8qSDcEqBM24HbjDX8zsUn9GAiLPcYjYPnrT+1PWVB03LiT4GLgE2fA2KHxJ84ch+ZaOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=modal.com; spf=pass smtp.mailfrom=modal.com; dkim=pass (2048-bit key) header.d=modal.com header.i=@modal.com header.b=YEbFykhM; arc=none smtp.client-ip=74.125.227.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=modal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=modal.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=modal.com header.i=@modal.com header.b="YEbFykhM"
Received: by mail-pj2-f40.google.com with SMTP id 98e67ed59e1d1-3a0eeda3e03so26428a91.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Oct 2026 20:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=modal.com; s=google; t=1790998275; x=1791603075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=97uawHidSB1rYodKjDdjsSlDXIsf2v1irs/NqM+eBxk=;
        b=YEbFykhM2s7/3XdWKcK0/+SMSoS75B6Nd4hous36njE6rHs/lgYTcUjKbfxS9TubqN
         M7fBNS570A5dHSmHT7tNQ0a9Wbc7tKuHQ2ONU1fLvcz07X+STgeCRRw6zwdAxtDCptMO
         gxFubpCxJ0q8bfZg671sUgMGmm1X+//Xw/LNzRxlVBhOr0c8EHWIWnAuQPI/16HkqGXt
         5pgLf8JjGESOMXI8JxaSWzAc8Ik2kxOLMpTCJts01rwHlUYWdchSLLjnu9tJoKupBJDM
         rTh8vjnTlOOfmD8pSlFTVsZ/bQiiv2uP86q02HgYHFBwX7RnOP+uxvg+joPDZsulTJGd
         WRgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790998275; x=1791603075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=97uawHidSB1rYodKjDdjsSlDXIsf2v1irs/NqM+eBxk=;
        b=Bv6W2vCXt0DdtSh02CWtDZvSmvkX/3fw0LHE6qudKDPO90x2wa+pRZn6jSEXVIDKx4
         rsNBkNbN833GQeB7AzcGEo9Pols4z9+PCyYqn+7N+P68lSiU5RJTlImyFJiPlI0ffJrn
         x/zxSmQk6bp13uZsmF/uRomTmBXIllst67907/5tVL0724Q12ZxqvmU3yhw9tMeKrg8m
         Ssz9yFE3UDdWmd4tR44TrQ/3buce4eXbPUzZnV9dfslzqArKmFHIP9f4YznX7faukW2o
         sSVO/dx7G+P6oCw7NOZCUyacSQVBW+OGjNwEqHnhuAnfp1L/9rEaw0vAjtX8pFqlapHp
         oPaQ==
X-Forwarded-Encrypted: i=1; AKwUvBz4n75uhV/0hr//+SNTUs9gLP0pV8cnqM3etP6v942mwNw3IAlWfAZvHPq0Y3CmOMtlx32SVXPjQE1vXZOY@vger.kernel.org
X-Gm-Message-State: AFq9FYJLxrFFTlU5X4Got4UmkZk8noDkRWSbsQiFHtfJYNC/7QKj1Kpd
	PXl/RmcjWij1/c3Jfag6KzpP5SRCQ/PWdaCH5gQGgXKISoJmmDlO5hkiesENU09pg0k=
X-Gm-Gg: AYBFou2EYBjzz75rHCnwD6DSAFa79ackaTpLQZnE/i55Y2UCcebD3+ayMaq+GkVlLWi
	AXZaj5EB20493b+Rjq5eAXsEwwXl2I89KfY9KrwmeBIArLcmrbW5AZ1AGOMuVHmgaMW3qjE3xEl
	WMSqdwO6zwADIzabuKcTEwQatk3cVs7vnctgFljQuCUZz/rEiYFBnK49/0xQkOvKSzl61l3y/NX
	PWFX0/s+1bZE9GX+VjfjbG/5y1LSA4ixzNZG/2nq1iTSK5o1+L0EfA5w+20vPzufnv1youIBXqh
	8y9+kE6lN17HxVjQogaIPFJwfP2IEPlsSKdliqnuBj3tyBg1GH+201OC5981XwGNrprWGXs02Uy
	+7Q+Ynw5CfFcUSHMlra6hwDMaV5jWptzTSkw4y4rMoFBoa8r/9vi3m1lAVKt41e5YSeDBAQjhrJ
	Eu04rNb6asdeRl/PBSGQxHqfteuNnmIGDQ1NAOD7NR+z6s4jQauqWKoGcAvPc0RodlPLZ1T6bTl
	g/BQq0068sg+M5lwksA9mV9yL6QUWaEagHV38Mi4/hPjp46s2McIe9J2QwVJMzuyZN1GPu4brvk
	fCL8LMSXN7ydgM5CC5/toFo4BxjSahK17PYFPg==
X-Received: by 2002:a17:90a:fc47:b0:3a4:a3cb:9c8e with SMTP id 98e67ed59e1d1-3a6ce7f243fmr1649986a91.38.1790998274745;
        Fri, 02 Oct 2026 20:31:14 -0700 (PDT)
Received: from devbox-ayushr-01ed.tail5292b.ts.net (ec2-44-242-192-44.us-west-2.compute.amazonaws.com. [44.242.192.44])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a78e4f3911sm1184151a91.15.2026.10.02.20.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 20:31:14 -0700 (PDT)
From: Ayush Ranjan <ayushr@modal.com>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Ayush Ranjan <ayushr@modal.com>,
	Hugh Dickins <hughd@google.com>,
	Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jan Kara <jack@suse.cz>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	David Hildenbrand <david@kernel.org>,
	Gregory Price <gourry@gourry.net>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [BUG] shmem: FALLOC_FL_PUNCH_HOLE vs fault-around race corrupts page cache / rss counters
Date: Sat,  3 Oct 2026 03:31:03 +0000
Message-ID: <20261003033107.1488699-1-ayushr@modal.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260925065013.3682431-1-ayushr@modal.com>
References: <20260924061708.1645968-1-ayushr@modal.com> <arTdLsBENhrpOyk-@pedro-suse.tail5790ac.ts.net> <20260925053027.1998394-1-ayushr@modal.com> <20260925065013.3682431-1-ayushr@modal.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

Gentle ping on this. The reproducer in my previous mail [1] triggers
"Bad page cache ... still mapped when deleted" on 6.18.46 within a
couple of minutes on a 128-CPU bare-metal box, with no fork() and no
gVisor involved.

We continue to hit this in production at low frequency, so I am happy
to test patches or collect more data if that would help.

Thanks,
Ayush

[1] https://lore.kernel.org/all/20260925065013.3682431-1-ayushr@modal.com/
