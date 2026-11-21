Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795256364;
	b=m2twVpZsz9y7BuqCsGmsCCUjwOCHwsck2iKJ5P8NXmfxNmNdPxlvzrzrAqdWX+j0buix
	 cn51XtFnBG+s4erFr7NlfGTdnxacZzAc2WIjU53BXeOfEdUAHm4ZLSh06eBj8IavOdzRK
	 3kOxchqBP1WJU3/joIrVxq1zJF0prC5ffsg7RZ6cAM/nusA4D4MhETTwEjr/yxcuKMdHp
	 G3BgNhg9BwNy0oIeFp3G3smOMsRjMOoLi28jZ2L8+F4nkDmruw/F5/JjDT11uKa2IP/AU
	 0oNgviuz9wtD5S9Q7KLtB5AW7PA8Fd7cXLuVgTrWnBGwf46TjFL5u6K+HPegDYNCMHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795256364;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=N9CIh5H4VwprN8NFJCHt7BtCzMbNAPuxvGffemDSkdo=;
	b=d794m4uKYSWuD16YCmthtU9bqBWynpkyx+PeT4bQaffgMU/q0mFxikIfvrPIwNcdX/1h
	 hbuStNoQbVYJlWp6sFASpkoUrEG3moVm2xhB1wKDB8XFpN7NBIv9o7ZM9Gq5XdeY6A/TJ
	 Zeqwh50dLtGGBRC+o4TiTeqif3dRb7pNejRJHA4pvQhvWfiUSzWhRy7nnGFp954Zuec9K
	 5Ekj5E7cBahyj7KE4votzWVIAs9StgpITT6YGUJOIo7fBmuKZ2VnrFovgnc2Zn1s4nW3V
	 eIVLy4iGRDsJPW9bJ7P+Th8G6SeuiJVl94Um5kiBprdKMuUAGkoGVUfTirjzswnxGYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unc.edu;
	spf=pass smtp.mailfrom=cs.unc.edu;
	dkim=pass header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=hoiEimoX;
	arc=none smtp.remote-ip=209.85.222.175
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE41A606A333
	for <linux-fsdevel@vger.kernel.org>; Sat, 21 Nov 2026 10:19:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE41A606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=hoiEimoX
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-9495f083657so214656885a.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 21 Nov 2026 02:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1795256363; x=1795861163; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=N9CIh5H4VwprN8NFJCHt7BtCzMbNAPuxvGffemDSkdo=;
        b=hoiEimoX408yjyDFycIzfZlVs0ZY1gTa9U7w/ErM8fupedSMctB3kNZr+vbp4eeGhu
         VRqjWyuIZkRRdQGOeKgJU1KWPhRwjBFZydw6/VOXUeNmgTiqNWNV29OjFKEjVTgPoF0Z
         nXvZZYtCC9EqKLdLrwkB5+zpoyCbmRQ6Y8nV3PKurhfMgup6cX12tEDRTdZ64LFKU7rf
         evSNyKtt7qb9NVT/YyLQvo02uZ1IXMWHSJmpCl9pd3In7+oLwbjipmEn/T3wuhI8dXHQ
         yDTOH09PePQ9XLaAbQo+ks7dsmGyspYKwigVaH7CRBrxGYuzVraM6+bwYrQWBq4/gDqP
         rNJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795256363; x=1795861163;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N9CIh5H4VwprN8NFJCHt7BtCzMbNAPuxvGffemDSkdo=;
        b=jgBNae4OvVA561K0IfACOgdMo1pOQGuoHudkI1gUPILS//L5x9WI6MXAeGjEDEaazI
         Yq/joSKPceIGUUXbXGvs4C62cgsT0Wn51IyrSCI1d7qXtqdXxuc8ibXMA1LjA9b71gRk
         btjL7SLLCRo4pVm1hwU+JeSlCtDcv7IOEMmjSJTsEtHMxc4b7gEey/ru1662B0JKc+e0
         2bnwVbyGH99qlo/3YKLQjcKojMUBnUvZTZcTus/RpPGt3YtdteNzt1Wz+NpVk1G2qIA5
         VAwN7XMvisiN0c5i50zHTWGpNPAzq/PKCxwuTksW7vZOtgJG2Vj4wgsE0TyS+nMcnixN
         GWOw==
X-Forwarded-Encrypted: i=1; AL+hErFX37T6zPCjwCHXJ7ikNJRWeMdctLfB4LRYNWeERlQ5Hg1yP2AveNUACmdQIsDAPDMmlW0vLWXGOF343VMF@vger.kernel.org
X-Gm-Message-State: APuU4Z8oDc0FhWt8mALtoh+ICqce2fn/2tCyaZLzUQkSEx9vq11TodLK
	QymF2HL1gm7bGOrcRt8IqCqpWzvYNjRf7QbSBYGZXf0S++PGNsQ/CHA0lajzw5fWtg==
X-Gm-Gg: AZFdTZfO2KcwRDwicow0zzKgjAGx7TxE3uIb7rt9egHiFy6uLB7zL5jV4O5OvxRx+6M
	qYyvWzpdPM4+60MnA60uGTO0Mg3Op6WGRpThionC0FfgCql6QSa7Byf0wov+EX6iUTT5qMsx9bo
	gTy+gkCaKQ8xBUQFSRKt/z5KGXt3E3cgX7S6hB9278QHhRsgBnSWEjk0Jp1sVqRRoNVD6uO7Z+o
	8pxA638RuDxP9ww6N9Lcc5HKjUOnrb+7ZfpdzMjCUbac9vb3lo/2GtFoG7k03j70y9P2qqBKGs1
	iJ4K8iD6wk5JEF9kaK2u+vhv3ToOMzp0RpUdxBJ58cQI6ddVjVxvNgZQT/wYGQAXlAUi0fJlRpu
	yCuydmWWbU3HB6/CIhvwKiiZ0NUjZAfaaKcyybXiE4hON1TB4Ss92uJOF5+EetOPfzk4I87+dCN
	jlUdQPSu8KrbGYsg8ifRerncSHA5nSkObIlDHR02mKu3acn0QvVQJw6hvYSSpDi+vWVnH9P33aM
	I/INaEIuOvhgnBH5vNsIVhOcNUIT19D81LJTTby+COGfQ0aZhs8oTWzfBhqUTvfAXQtZnVEZTkM
	Xbh3eyTTVSs/b3w1tTvW6Dj/eRutxtfOuSaH1m55cswS2dEm27A=
X-Received: by 2002:a05:620a:601b:b0:949:76ed:591f with SMTP id af79cd13be357-949ba82851fmr949300985a.8.1795256362690;
        Sat, 21 Nov 2026 02:19:22 -0800 (PST)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb35005dsm393964485a.11.2026.11.21.02.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 02:19:22 -0800 (PST)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: slava@dubeyko.com
Cc: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] hfs: avoid reusing occupied CNIDs after deletion
Date: Sat, 21 Nov 2026 05:19:17 -0500
Message-ID: <20261121101918.3395879-1-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <f59ea6b2a8c60594361ab596d92bdf98a217dd83.camel@dubeyko.com>
References: <20261112110128.4082071-1-hengyul@cs.unc.edu> <2bbc10eb1dd5ee69329a9307f14fd15b1815b898.camel@dubeyko.com> <20261113194103.3825961-1-hengyul@cs.unc.edu> <f59ea6b2a8c60594361ab596d92bdf98a217dd83.camel@dubeyko.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Slava,

Sorry for the late reply. I have an important deadline in early
December, so I may be slow to reply until then.

On Mon, 2026-11-16 at 15:21 -0800, Viacheslav Dubeyko wrote:
> You explained a simple case. :) My worry was about the case when we
> could delete some number of items between [16, 20]. For example, we
> delete 17, 18, and 19 at first. And now we delete item with #20. So,
> leaf A should have 16 as a maximum CNID. And we can use 17 as a
> next_id. Correct?

Correct. I ran this case with the patch on a fresh volume. Creating
a, c, e, b, d gives CNIDs 16 to 20 in three leaves:

  leaf 1: root folder (2), thread of 2, a (16), b (19)   max 19
  leaf 2: c (17), d (20), e (18)                         max 20
  leaf 4: threads of 16 to 20                            no file or folder

  rm c (17), rm e (18): not the newest CNID, next_id stays 21;
                        leaf maximums 19 and 20 stay
  rm b (19):            leaf 1's maximum has to be recomputed, the
                        root keeps 20 (from leaf 2)
  rm d (20):            leaf 2 is now empty and goes away, the root's
                        maximum has to be recomputed: leaf 1 -> 16,
                        root -> 16, next_id = 17

The next new file gets CNID 17. I checked it three ways: with the
values cached before the deletes, with nothing cached yet, and with a
remount between the creates and the deletes. A debug build that
compares every cached value with the records after each insert and
remove found no mismatch.

A larger case: 2000 files created in shuffled name order, so the
CNIDs are spread over the leaves. Deleting CNIDs 1916..2014 first and
then 2015 gives next_id 1916, and the next file gets 1916. Without the
patch the same steps end with "File exists". fsck.hfs reports all
images as OK.

Thanks,
Hengyu
