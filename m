Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E0081ACD
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2026 10:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781777586; cv=none; b=cZi6I7crOKhIr1cIPj9clzkcTLJMrpCLpCFSSBIwxxa9+BQFEQv03kstxg6XPANsS1cHTWyaMVXuMmAl7hlD2WVHqaA2KWePInSgbzLBMI02R82qcv1Xz9PVlVCRB7KeHiNQlL6W75DSoS7JcMxuRcHLMQafJ3Gv9s7krb8I6A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781777586; c=relaxed/simple;
	bh=Sydr13YG+LkxSxLb+VuMhlfM2ZmKIZRGOQOOc2KpBoQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D67uUnP8wo1hz8OjHbe2MQe9yg0+4Mlm14JF1F3yobRg9w0IewBwAAQlW4AK8LhmRbg6PDYrHXwsy4mVOuYYki336JD/ukzsXqOtqdTLWUM38hMwZ1u0H/renmtWtjuKfpkrsifon1ITD3vLQsL5V8tZ5L/yhP/VSx9Qybz39eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YmoJAynZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JU7PgXEQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YmoJAynZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JU7PgXEQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781777577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UfQC3jb/IcagHhe/VvLJeUD93AwtwhorZYSoiCqw/vw=;
	b=YmoJAynZb3N/3XSVIysM1Cric0kXGlvX6ofpBIX/JjEKX47ksk/w5e/bFLp9tcRBI19tOG
	8LbvkchS5ZPYsPtCnJOJLr4ADAqF3iIeBa2+JZE6vo/EU0IZfRy1obYBlaOCEeKIgUyed0
	JtJvP3WnK6I2fKN9isaVIpLFvwGpAOM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-hWFLosG4O26urfcyNxfyPg-1; Thu, 18 Jun 2026 06:12:56 -0400
X-MC-Unique: hWFLosG4O26urfcyNxfyPg-1
X-Mimecast-MFC-AGG-ID: hWFLosG4O26urfcyNxfyPg_1781777575
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490b9cd54f3so4647335e9.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2026 03:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781777575; x=1782382375; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UfQC3jb/IcagHhe/VvLJeUD93AwtwhorZYSoiCqw/vw=;
        b=JU7PgXEQ6wrjpSwX7zc9I7/74IAXdNkzaFbWiO8CSDIQfcPEIY8ftNuiKznfHR9dp4
         C92w5AEP+8T6xREW+x1JP6/8DRG3ivF/X/ApIzP3TFn9Noh21EJi0ZMF6skhfYVlIGLm
         4rAczC1friBs6TQHgfd84onOWAL0Vqm2RUlnwXyWTPM8H0mBEeyrgerY/1Ef3557jAky
         9uqJURszRo/oIO072iTIhJvYWUQQiiFqYtzfA8xD7s5yRRxeITTKd6VPjZksAG+rhna0
         sArdkWA2X+zDlJkAdvE0THMART64doB9/x6VTKSdk2Rw6upfiLGWNcY3R4JJ2Sv7N/BQ
         lAhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781777575; x=1782382375;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UfQC3jb/IcagHhe/VvLJeUD93AwtwhorZYSoiCqw/vw=;
        b=m+uUL8cKfFkH1545XcY69o1c9nzDAq9K91I6mN8zHzoH1S5rDOMYpfYAIVmc2pXSsU
         0z4nfJdYjVtKd02Awg4lnMdJbSNqRla7epfvDj9/Llt4HDYcH2wb2bx93VKVvbanMrzP
         qaLPrROrgT97+PiFAXKTYRqR20WzNbucHOITk3HvMqrpfsThemA+If6oJqOlKSxi7W0W
         EkPz8dvoHzvpckEhjkXKLmSE/Ga0jQjuto35bNKqmfH1m5Vht3hrXSbOBeibtnK//cb7
         lRe4v3xBsWcNJqIVj7evtawQ6PY1N7H6yMIOoBljHdoDKeAAClzclYefdyWVuoOUWbnW
         Y5Gg==
X-Forwarded-Encrypted: i=1; AFNElJ9hnCvw6z3BM9B0j8Pru5l6HWcxAiBk8GGxjUZBIj9WDC3W1fiLjHCO/Tla7l2RC0cY7w9vDLj8so6VClwe@vger.kernel.org
X-Gm-Message-State: AOJu0YyMRr5fJLMk1U302c1Pr1Wy3mbRifJiYaAjiyPwZ2iGG4C+2nm0
	nMEQE2bpxxvFDbuNvsLbvibUEYAtmQ4yyeMbX51QlhG6+B9joi1zr218OoA38D2fFT6H2GtwFqT
	cnVJME/gXsPA+X1RxI6ym4MqteTGEymssojPQKYQW7gYJqUbY4mGscgSZz0iLWKdC9WQ=
X-Gm-Gg: AfdE7cmpnlXRpPd2hew5BrNCkc0cArjd+iP3G2aiCaoWq4msZDheIVy1Y7QWs2IkOUR
	tfTHgHcjYIv/fYSeXOFXIJD24ERgAt4Z1e/CIsxaqt3wxYPiE+2kPiYxIqcnHHc6gb8OLXl9V5y
	CSRrL7i18QY2zHHQS3rGKx/trBH5Ya7FsnvKZdcRf+78fgcaP0qotUydHSt+ql8KbPJxZuXx/Yk
	ICndRP6+DHNpFakuOflP6dnQNMkTDH0EJzJKXo3NM8ZaK6s0RjVSLOqp6/o3VP+IKt0P79SygZg
	OtDlO68xXS1wUom3lW8tRPxofWUYHwREPfwqug9fqg/VhjaovcNVStPLPjRe/OQsHy3BzIhDqg5
	ZQ7ibsip6IVjGyTdnsCzjQfuhuoDacfDasB8oFgvbDTE=
X-Received: by 2002:a05:600c:83cf:b0:492:2e1c:1d19 with SMTP id 5b1f17b1804b1-49238225f8bmr45515335e9.31.1781777575348;
        Thu, 18 Jun 2026 03:12:55 -0700 (PDT)
X-Received: by 2002:a05:600c:83cf:b0:492:2e1c:1d19 with SMTP id 5b1f17b1804b1-49238225f8bmr45515005e9.31.1781777574985;
        Thu, 18 Jun 2026 03:12:54 -0700 (PDT)
Received: from 192.168.1.130 (cm-93-156-201-22.telecable.es. [93.156.201.22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49230a96d14sm216388815e9.12.2026.06.18.03.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 03:12:54 -0700 (PDT)
From: German Maglione <gmaglione@redhat.com>
Date: Thu, 18 Jun 2026 12:11:54 +0200
Subject: [PATCH 2/2] generic/633: add _require_acls for tcore_acls() ACL
 dependency
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-xfstests-tcore-acls-fixes-v1-2-45a1aec1d99d@redhat.com>
References: <20260618-xfstests-tcore-acls-fixes-v1-0-45a1aec1d99d@redhat.com>
In-Reply-To: <20260618-xfstests-tcore-acls-fixes-v1-0-45a1aec1d99d@redhat.com>
To: fstests@vger.kernel.org
Cc: German Maglione <gmaglione@redhat.com>, brauner@kernel.org, 
 linux-fsdevel@vger.kernel.org, zlang@kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781777571; l=683;
 i=gmaglione@redhat.com; s=20260618; h=from:subject:message-id;
 bh=Sydr13YG+LkxSxLb+VuMhlfM2ZmKIZRGOQOOc2KpBoQ=;
 b=9m7U4QL2Dq0hpstvEpBvhq+iw3qnU71AL/fKsHUlU64ciQaOMdi/CjYBb/uQog0Fg3G5FkTj5
 5tQMvDf0GHbBC9yo13Gn3wUTNactXxe2HAP/MMD2uOswkcf2U7HWTs1
X-Developer-Key: i=gmaglione@redhat.com; a=ed25519;
 pk=EgoGsSGnVamWcruH9kiHxwzZf0dPTHHxIjd1Gigd+yo=

generic/633 runs --test-core which includes tcore_acls(). Without
_require_acls, the test fails instead of being skipped on filesystems
that lack ACL support.

Signed-off-by: German Maglione <gmaglione@redhat.com>
---
 tests/generic/633 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/generic/633 b/tests/generic/633
index d75d4dc860d3b78e5fe11b538e3aba4e9ab477e1..90d24f099bc732d5db209f8d014ddaeb042985b2 100755
--- a/tests/generic/633
+++ b/tests/generic/633
@@ -14,6 +14,7 @@ _begin_fstest auto quick atime attr cap idmapped io_uring mount perms rw unlink
 
 _require_test
 _require_chown
+_require_acls
 
 echo "Silence is golden"
 

-- 
2.49.0

