Received: from mail-oo1-f68.google.com (mail-oo1-f68.google.com [209.85.161.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5B73E9591
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2026 13:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774964640; cv=none; b=hpd5twNpKYS+kOOVin9TRaaa5IHMNMY6BXBwTIt980rz7gECGX5j4XTGAnLwmR5JVegktqN/EApf/HNuFpv1hoSZMXuzrXiLYlcSquJcESgc6qYaBTo2fqJLcPetd5WewnwExGxqLMMkYz5FXebOlZIZxhDOGNuLe+rdNXrKAmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774964640; c=relaxed/simple;
	bh=vDHRx5/RTLjvU+iTwg1KIOBbJHh7BzRF7SUP/ABKQTs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BEl4Fb50an60CFMvmhcslBmCHOljf0xNmmHj2RJ2W12mV0UedWEJewUlPro68Nwd5t3pnHjQHtIBt0VqAOADD558NHLa6QoNmVaUe7vMRpQ3g0zWbn6Cwz8dmrtRnnUhJYpCWj+ZUv82vYNcdMlzMHmDosiWsD5HePEFX85Ve6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com; spf=pass smtp.mailfrom=amutable.com; dkim=pass (2048-bit key) header.d=amutable-com.20230601.gappssmtp.com header.i=@amutable-com.20230601.gappssmtp.com header.b=eFa58F9S; arc=none smtp.client-ip=209.85.161.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20230601.gappssmtp.com header.i=@amutable-com.20230601.gappssmtp.com header.b="eFa58F9S"
Received: by mail-oo1-f68.google.com with SMTP id 006d021491bc7-67deb70bc76so3159539eaf.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2026 06:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20230601.gappssmtp.com; s=20230601; t=1774964635; x=1775569435; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oWgQv7KlmU17zr4FSCoT9B9zPEkLI0N3J9fgtUr43qs=;
        b=eFa58F9SHQRnokttdm30Y9chyTtFComcMMO2BNmEpm3fILWBXd0uc7Qum6EqldwEMU
         s+HbjvF5+cYiw1KVd7/Ycr73JMWBOwV2Nkr2/Mh18SGU4fagQ1mD66klOSVqzxMyhCfu
         32rMnN2AunL9eeIKE86+S7lcg8b1zanoANFRxAj2vdTgCFK83A/oiuI76Qpg3fNkcJiy
         E/5QHl08eBxiTT/uRuL+vsGoyKpKMD3JJT7lBPu3nBVYcgslLbLdqgXu/3Y8oNlIbCET
         51BwvxRcw0c5ekwBBQP34l+49eT3RuAcLGfH22QCdOCJqHYtHtoUPJAC134vSzMtU8RF
         w9/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774964635; x=1775569435;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oWgQv7KlmU17zr4FSCoT9B9zPEkLI0N3J9fgtUr43qs=;
        b=OwzKyR/GoSVIrnuV3MtvT24uXXaUU4AIqBd7WwDcrECeolgHMcjDPKsVgeVFtzHJWb
         CXX0rRrtxeCGwWux34/GiXifbHBkZux9pVCK3/LWMKHOAIBL7ovOPgEPR6H0uyFUtFo5
         wjAvaTJU5l4CGPmaiNnuy8j85Mh5Xt1uXVJySxjNRub8cS3dn+1H8whIYA/r1QphpHKW
         G6x1ZLsDmaIeJ5Zp2WlqI8qvsEMRuX6Gxu54juWysM2ImQ9+e7bBg7z4o9hphStfazLh
         pckevgE1AxHCMlq77Q4wC+8Tou9aYaR4AUo8WiTwcygiJhrNKqrcLK+Q2BVYyPZTJvNZ
         oYTA==
X-Forwarded-Encrypted: i=1; AJvYcCVu60GJ6fpS3CbNeU6VgpcPo1/ITM8GqkiNGZ25fecb+tRXEhlIzH9vsQSrb4BnOFWO7/VceHeIKzlWF1DU@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8SP+sKDSkLNItmSYoSqDn/EgBllXmLt3X9KJMpxxICXgtnmZE
	+Jy+PCkzJ3U/Aih5Q3aqUnVkOp/niE2FqGV8/2poKKGVK3sX3t+ORBfpL/F6ZFcqKX79
X-Gm-Gg: ATEYQzzhQE6VkDimnHH9CTMkidPk34ZdSvqCfNKhXedRXKTVkmSh0qrio6vCBSsYc9u
	QYM1S/VdI5wH5IFGFeA3B+5BV7YK5CqE/K1i4XxkTYeV4Wa+ijrjDyHaeBnF0W6wsv7mw7l079j
	XT9elXrP4gEeERldR9LWn1Cd1ItOVOZNYlProDvEFOBhWGNtcBGH1ty6TjolFugohXRV8XEPXq0
	eTn4+RRdcnFWFU4o34RdWpFcHjZHifJNlGfEsXAyKAiC0q1Og9C53bRytgTQiRvFxGy3EYz4rpX
	Bv60MeSa/u2BCFz5TFbUwbR0yljtzllFMExwHvvD+pIeSUc7f3oa1mijYDzrJsxVP0cgGVDM+Ce
	m/OX/9xAbFSdT+Co6AUD4z+ARDoicD62mEHkSfJ2uFgXp8HHEAE3kmcb5CBnw5yDV/syaSKOb/g
	3T3IwEaObA8NGRnm6ZfaoUvxKcKZl4Met8hVH7e/o1Bo14TaLKSuNYbSTMp+Yf6aGrBweWs6R9P
	zwZte/od334Z4NctxwTxaeK
X-Received: by 2002:a05:6820:290c:b0:67e:4189:814 with SMTP id 006d021491bc7-67e418910b8mr985500eaf.35.1774964635516;
        Tue, 31 Mar 2026 06:43:55 -0700 (PDT)
Received: from thesius.dot.cyphar.com (2403-5809-a2fc-2-a90-9fd7-aedd-d405.ip6.aussiebb.net. [2403:5809:a2fc:2:a90:9fd7:aedd:d405])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41d04d95bcasm7470456fac.17.2026.03.31.06.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 06:43:55 -0700 (PDT)
From: Aleksa Sarai <aleksa@amutable.com>
Subject: [PATCH 0/3] selftests: openat2: migrate to kselftests harness
Date: Wed, 01 Apr 2026 00:43:30 +1100
Message-Id: <20260401-openat2-selftests-kunit-v1-0-5819ac6cadf5@amutable.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAILPy2kC/x3MQQqDMBBG4avIrDugE1DsVcRFqH/qYImSSaUQv
 Luhy2/xXiFDUhg9m0IJp5rusaJ7NPRafXyDdakmaaVvXTfwfiD6LGz4hAzLxts3auZ+dKMP4gA
 ZqNZHQtDf/zzN13UDOLZ5RWkAAAA=
X-Change-ID: 20260317-openat2-selftests-kunit-6939af23ee27
To: Shuah Khan <shuah@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Aleksa Sarai <aleksa@amutable.com>, Aleksa Sarai <cyphar@cyphar.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1119; i=aleksa@amutable.com;
 h=from:subject:message-id; bh=vDHRx5/RTLjvU+iTwg1KIOBbJHh7BzRF7SUP/ABKQTs=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMWSePj95p7rE1N0SqxjPq0+8czemNiZVme/OF9c51skv4
 u5PEz34p2MiC4MYF4OlmCLLNj/P0E3zF19J/rSSDWYOKxPIEGmRBgYGBgYWBr7cxLxSIx0jPVNt
 Qz1DIx0jHSMGLk4BmOqweEaGP+euzVOyS2ZKW5JzRsXQ3H3XIzudU/cnpVrc9C678PBBLMP/+nc
 xd3p6Ehnjd2xQFwlLuCuaZf8n2fHLK5mg7uN3KiZxAQA=
X-Developer-Key: i=aleksa@amutable.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386

These tests were written in the early days of selftests' TAP support,
the more modern kselftest harness is much easier to follow and maintain.
The actual contents of the tests are unchanged by this change.

Signed-off-by: Aleksa Sarai <aleksa@amutable.com>
---
Aleksa Sarai (3):
      selftests: openat2: move helpers to header
      selftests: openat2: switch from custom ARRAY_LEN to ARRAY_SIZE
      selftests: openat2: migrate to kselftest harness

 tools/testing/selftests/openat2/Makefile           |   2 -
 tools/testing/selftests/openat2/helpers.c          | 109 ------
 tools/testing/selftests/openat2/helpers.h          | 164 ++++++---
 tools/testing/selftests/openat2/openat2_test.c     | 223 ++++++-------
 .../testing/selftests/openat2/rename_attack_test.c | 161 +++++----
 tools/testing/selftests/openat2/resolve_test.c     | 368 ++++++++++++---------
 6 files changed, 494 insertions(+), 533 deletions(-)
---
base-commit: 5e4e16d498eccca363db526433803932921dd74f
change-id: 20260317-openat2-selftests-kunit-6939af23ee27


Kind regards,
-- 
Aleksa Sarai
https://www.cyphar.com/

