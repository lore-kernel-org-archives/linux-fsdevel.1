Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E523CB8F5
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2026 22:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787870236; cv=pass; b=aBOuHvCX3jdrnmjme0PwJVEgBlL0qXW24hdsyX2lyA3z/0ZSUpU4Z4PZVLyOYN2CJiHyQK3f4QxuX7mCiULROOnVksHEu2i+eY4iBVGzBdoMduQs8emtFnnUtGc2MW4ez12z8zpT9AWY20rxcFo8ZU7q+nT9Qgq5vSMVyIsI3Bg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787870236; c=relaxed/simple;
	bh=1FhNBn8HrrMBGExkBgk6a5QrDZ+d7pHay6JYHWvqv+A=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=GK6FwETYaij3xVK4vwpE82Z9KoRGhqsbQuXTeLQI6RCp2rT4kRDDchdFH3bkzJuKAxEtkiY7mIuDS+GqpHibeTaqjN59Rmb6u2LZBMYrfzLd2wUuSjyfonPH+Qa5NdjKmxDVUCcNRCm1ANdeYAyhD+2IirSSLf8TKmgbK2xC3Co=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu; spf=pass smtp.mailfrom=berkeley.edu; dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b=hS6EIzLj; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b="hS6EIzLj"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2d6d28aa26cso2915935ad.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2026 15:37:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787870233; cv=none;
        d=google.com; s=arc-20260327;
        b=M24a+6tuf5WT5pgr0nCalbXRRuQ3xkAL8quV0pXma3x6ErHd6kOHspfnHNLxZMCbCE
         6VyWO0Vi5DL31LUqrGeoK7nTp3PCSmW0uL5s8RtFmhe4prM4yW+u+TeYDe4kAdMWiAFw
         Zm1tBUlIvxYiQaGpUkydlufyvY2DnlGVacqVk7Uo019c8I6vwxmvwtp7K2p/y2Ah+J+f
         qJh+inXKzHRpjrqS9owFPhIreR1TXrWKEiVtk8ergPfO2ApempZcpmWtr5NzlX14rGgF
         5x5DCbT7qMqU/8f9HnIkia1PNxSKB7GOidWWjvQPKo3GW1mkllWsvL6gCaiaEbHVoJku
         ubkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=Eq1s1DNfITBZf3cFRPXUrAig9Rh05gskqzjYAwCiF30=;
        fh=M1YAl5MmFQBN8rdhQDMrRC+1pPTrmsziW8JbjumzlVk=;
        b=LUQ0ZqhHVIhGI7uokfF23bsmtv73qFc6qqQEmff4CbiTlM4Q2f8G+jGOQVtnXge28B
         fLhBZfwlPL7o9GaXCygvg4NuVA5oPDaPqi6Ng5KtFL7fWIz94ZpbqzSFfNOJG8bRMiS8
         D5ph0Ww/Nh5hWF0CzxOKJ5GxirLC3VtHNndE6Oxmv5S4NtaqglUJrYjY8LXCSrTxhW4Y
         zPvgRgv50BnLVZeEDj5TApc+lt2qob/8TnEcdYibuEQVquvmkL3MaRPUr5YsweGpGcrT
         1ImhxdvC4MdOyLC3Dfc/tVV07MJTb6j8qFjBs7tbfvOqvcLk9/0Z20SOGY+/D+6r68q+
         rYaA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=berkeley.edu; s=google; t=1787870233; x=1788475033; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Eq1s1DNfITBZf3cFRPXUrAig9Rh05gskqzjYAwCiF30=;
        b=hS6EIzLjf0xmX7unGVDgkAxPMdnrZEkVVlxAdUgNIKnxTXXWqie8boWuNY0iN44Vyt
         UP2GNn26JxgwqVst/xwZ+OmwnqUMb/8litzTEKcoIhd3VkIPALYTw6C6aFbFPo9oZyUt
         LtrM2AwTPS+EPLUA64qvYnpLKzNnEKT0itJvAAEkM/LDHKaiOK8XtEwhmj1T8lKByetA
         6FG51jTJk+MRpXmASPOrqjcivLevEEnlF3BQINomu1mbRv8oBl1e8aoklPJXRPSncs+S
         txzlqJoYHIRUsNqiyWnizPxoSoOPKc4UJNUfIDD+18l8J5HqzXySDgEW4oITV4WYJ8/p
         ZoRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787870233; x=1788475033;
        h=content-type:cc:to:subject:message-id:date:mime-version:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Eq1s1DNfITBZf3cFRPXUrAig9Rh05gskqzjYAwCiF30=;
        b=lYt2wdvMLuJj2mC+POdShLVV53vbZTzD5+bFiXH8knbGlTtTxuh0I12vqYoAfqItrg
         9lp/qkf/bNT7cLdnBx8mpVHvAOyrQGQdzSKCHiTsMCrnWXuBjhK5fuuVPgLzQkkxpOGK
         Sl+lKSyaqQETBEjKlHfK07avcNTRvqauXP8QwCyCJW8tr3QFFKVkD03Li/VLKXlUHEwq
         7Vvo0jMVt5r8f31dS4O5IHHquyYGaqztL/DxADSEvdBUA4S6pcnCv4EBaVPWTwKkrneH
         CU1NF+LHK3+ZbKht6xi/WAHnIN3Ro5HTnWSPJg0k6CVVY2UEPt1OfY6AkKKib2BWtoEe
         fUww==
X-Forwarded-Encrypted: i=1; AHgh+RoT3a3PvxWnhTJlPF9VHZZGOdsdtVwOVvtNQ0HxGAVt6mM4AXgh2znKjngXDX9etX6XwG1h45cvpK+CAXSj@vger.kernel.org
X-Gm-Message-State: AFuF++mB40MqdV26IFxUaMHp/qjTQZh3ubEmXnyL0jfm+62tZaNu9Lu4
	l2SjaWh3JGhgz053i54Fe+DSEZt1kK3K9dpzoUkDijjzGHc1IthwBPXgN3Yb5YRjJsJGQvEijA8
	Toj3l17v31WAESo/PdV+hY3gh2ib1neyJcgR3eNY5D5rzbdQ1bOdjAg==
X-Gm-Gg: AR+sD10arTbLNsQBYJEI/EmqcMSvGWBZ4MROEtXY3ym3dyS4w5nBUPoqsscpLoNmjpv
	ey4RuUmogI19+zbI5f1+ZI/488urLFgMuMsXSSofCjRIz9a/YFqxTD5JsHUUpApnRd6iW1Kljiq
	qDUr7k+ynzXX+AzeMGp2MZu9aC9tbpAhVtR8J3+8o0WPnXM/nzF4yzVQfq86B4HhxvRQI6gS2Ei
	L0HebToNu8uQj3XAZ1pyppuVJS/wngSqcsQuRLzJiXZ5b6McGAZYeXNFwuGa5ECoJeft1Uyhwhk
	KsSexUsxdLO7SYwPd9nFflLHpXpcSPPlxk7Q7OvK5VcfrnKIh3zH4iJqPgw6vnszBOu4epCeKUN
	G57XUaUM3hppK1GFU12sDqylE4ZYCQ0ei
X-Received: by 2002:a17:903:3803:b0:2c8:2808:3ec9 with SMTP id
 d9443c01a7336-2d74df0328amr45719285ad.12.1787870232038; Thu, 27 Aug 2026
 15:37:12 -0700 (PDT)
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Aug 2026 15:37:11 -0700
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Aug 2026 15:37:11 -0700
From: Farhad Alemi <farhad.alemi@berkeley.edu>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 27 Aug 2026 15:37:11 -0700
X-Gm-Features: AcwNN1XF0MbNniQ-xu220utGY2uYs2iV5RziNHwgcfgQ77-EEwG7ldgQL6XT9tE
Message-ID: <CA+0ovChcGF2nsf0iJNGXM79iGv2fKEqYi4DGQ55aygBcKg2NGQ@mail.gmail.com>
Subject: [BUG] afs: ERR_PTR dereference in afs_lookup_server() error path
To: David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>
Cc: falemi@asu.edu, linux-afs@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello David and Marc,

While fuzzing Linux 7.1-rc5 with syzkaller, as part of research at ASU's
SEFCOM lab, we hit the crash below. Crash reports can be found here:

  https://github.com/farhad-alemi/public_bug_reports/tree/main/104-afs-err_ptr-deref-afs_put_addrlist/

  BUG: unable to handle page fault for address: ffffffffffffff9f
  RIP: 0010:afs_put_addrlist+0x43/0x250 fs/afs/addr_list.c:38
  afs_lookup_server+0xd3f/0x1020 fs/afs/server.c:243
  afs_alloc_server_list+0x800/0x11a0 fs/afs/server_list.c:82
  afs_create_volume+0x995/0x1290 fs/afs/volume.c:227
  afs_get_tree+0x955/0x10b0 fs/afs/super.c:555

Our reproducer.c is available upon request.

Happy to test a patch if that would help.

Regards,
