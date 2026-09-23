Received: from mail-pj2-f16.google.com (mail-pj2-f16.google.com [74.125.227.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E5653C3A0
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 14:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790174995; cv=none; b=CaF4H5A/QwXBJyYae1BWtiy9Czi5g9VCkeQDSITgvjgjJaZK8OFsFlaB+SnYJ/j2qWY1njIa+SCQ6JLzV48SgjoGkeA6qZxGdh7mW4WJWQdE5NUFZnUOMWwl6r7XuJlURf710hNQUK4qE2g2hdMR3mqmk27T7JfpzlTGbtuJFro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790174995; c=relaxed/simple;
	bh=xJdKepmRpAoz1zQFvIxmXfvUfRSmnb1JsW+eRmMFwSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IwR2bJU5pdByU5eQ52aPnzq0A1CsCKdl0x544uScdyipu62YUxsGBwZxKpJxHRj0+n636KYOFE2KLp/7iilQGFtdDWNVRcYEKCEd1kkVl4aGiUg/xaJhvclXsdjJUKtfzkqTwNAipJyFtzPjyhAkYdh03FfknTeBtU22bwyjPd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mqs008B0; arc=none smtp.client-ip=74.125.227.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqs008B0"
Received: by mail-pj2-f16.google.com with SMTP id 98e67ed59e1d1-396ccd78e6eso407758a91.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 07:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790174994; x=1790779794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JjR07HVq5pYhUmwpsgEGWXdyXHF+ofIQx2iCJm+Z1l0=;
        b=mqs008B0oH2utC7g7dz1vj31Sy10v3bGiB5F/Nae2ELECmkplwwjwPT18NVenOGiMd
         k9aXFDeMzE1kYyt/f/HTtmrogGk4zjBLXG/8t8KbVlyyyoOZoykV1Y8uZ2W7g83xfQgp
         f2pUtD8foSxoSbHv+wTBRxXlcenPGVp85gf5MXiCC4xAQkxZsv3VbwDQffwYLlZTl0+Y
         DqNT/m/DmZcskmDAQT19duZZe3HO0jDkmMjCslsZJbwZtkr4nsl83L1p7cfpBWYb48ID
         of/+0FJXgJlgkY227EoRFoBBpRM9JSn9ZcuucprkymTgEszzEl6nm7arJYEFkdOuFUz5
         oQ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790174994; x=1790779794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JjR07HVq5pYhUmwpsgEGWXdyXHF+ofIQx2iCJm+Z1l0=;
        b=bkgcl9AJCwJ8+OpgqKtephtnffmRaMH79IzKHTpoj09orhvMjjWMCBmdrv7Fx2Rtax
         egDDxnjldGBScciB/MKqprbHd7nd7fXJ1UAZQ6lCAHTlloNOv8rienyx9Hwlj7cw754l
         +kU9vu55C5SnbeYVt2RbMdpXaVYyofHgwWUwM8Jk5NCh59jcGNcNE83+YqTxGdYkh+3w
         d8ZpWioNRrkQ1N8J3rDwzBYgqKy+6kzH5bynFwDOFTJzVzk+GzCKR0t0F8woe0ZtwTI6
         ZNGxFtglD51f5NCxEfYeykrpQRkRj5GQ/R9jfacWbLqUSiG/gA3pZ5AgSiGjIE/Nz1RE
         TV9A==
X-Forwarded-Encrypted: i=1; AKwUvBx3YGEr/1F5oEHAb29O2XHjRWs5xZLSmyQoKqGFsayNvj4eUfazN6G07cNKnRbAeIwoCC14vC8yBkhTCcAc@vger.kernel.org
X-Gm-Message-State: AFuF++mEu2Oypi1pT1gZ0tVpgZBlk4tznYTeF2wXGaClBagWPL6VBINp
	ektDrLaScE4dtfqWJcmjtt+MU3WmkYr2ie7L7oXQ/cIEgPKXNyRAOzgo
X-Gm-Gg: AYBFou0hJS7fsp2lLqwyghE1rl0FIZSwQgPJwoJD/TaaRPL+0ZB/dBG0Jyuv/eYqFih
	PDjL7F+vS0Zs6dauTlljsQ7xjgoHVjbB7rqYfpkV+m2DuMUn9GO4vcBP3BdjeymJxntaLow4XUz
	+ISF7+Vaopov+XYzmJCd8+C/x1JhBckJRJlmO9t7DpZdefRv0kf4LWN+kPFreBxjd2+beIz93Vw
	X6pTMn/EfboSHl7f1v7tKbZsTnRaIfZ3FeCFUVUGVmPQdC94nwArwpmjtpTgT9zChzfBMi5lyKJ
	5ZwGLbh58ljW9L4zt7l2TfUHKxR+oXI4pvTMsTnpYdLVGChF1sPFrdfVlmed8sg5sUjKeo3P4EH
	Y0hM45WbFXWoecQakwwQvpRleqvFO0pCwcbwzCVBq0Mw/h+1XRg/oLlfgBRgSo04LFzkgU0/3Uv
	oeA9Fsf11/G+8AgJ5N14qKTrqxblKRgrBcwKR0uRsF7I7EKK9nlpgNihkNtRwb1KtG5XswEPTut
	QJytbcMb08max01tLwNfw==
X-Received: by 2002:a17:90a:f947:b0:39e:6c68:fd93 with SMTP id 98e67ed59e1d1-3a07e6195e3mr1763305a91.40.1790174993687;
        Wed, 23 Sep 2026 07:49:53 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a07dc4109dsm6469824a91.14.2026.09.23.07.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 07:49:53 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Google-Original-From: Zhan Xusheng <zhanxusheng@xiaomi.com>
To: Joel Granados <joel.granados@kernel.org>
Cc: Zhan Xusheng <zhanxusheng@xiaomi.com>,
	Kees Cook <kees@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Bradley Morgan <brads@mainlining.org>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 2/2] selftests: sysctl: Check the sign of a negative jiffies read
Date: Wed, 23 Sep 2026 22:49:37 +0800
Message-ID: <20260923144940.3712965-3-zhanxusheng@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260923144940.3712965-1-zhanxusheng@xiaomi.com>
References: <20260923144940.3712965-1-zhanxusheng@xiaomi.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

proc_int_k2u_conv_kop() returns the sign through *negp and the magnitude
through *u_ptr.  For a negative value it used to convert the
sign-extended int and negate afterwards, so the magnitude came back as a
wrapped 64-bit number.  Nothing noticed, because no test wrote a
negative value to a jiffies sysctl.

Write one to each of the three int converters and require the value to
read back unchanged.  Each value is chosen to convert exactly at every
CONFIG_HZ, so the test does not depend on it:

	converter		write	jiffies stored	reads back
	jiffies			-1	-HZ		-1
	ms_jiffies		-1000	-HZ		-1000
	userhz_jiffies		-100	-HZ		-100

On a kernel without the fix, at CONFIG_HZ=250:

  # int_jiffies: got '-18372957097414713411', want '-1'
  # int_ms_jiffies: got '-18446744069414585320', want '-1000'
  # int_userhz_jiffies: got '-18446742229035144346', want '-100'
  not ok 1 test_int_jiffies_negative

(paths shortened; the runner prints them under /proc/sys/debug/test_sysctl)

Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
 tools/testing/selftests/sysctl/sysctl.sh | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/testing/selftests/sysctl/sysctl.sh b/tools/testing/selftests/sysctl/sysctl.sh
index ceb5cfa0cfd4..ad1ee0fccd7c 100755
--- a/tools/testing/selftests/sysctl/sysctl.sh
+++ b/tools/testing/selftests/sysctl/sysctl.sh
@@ -328,6 +328,29 @@ test_int_plain()
 	assert_int_range "$t" "$baseline" || RET=$KSFT_FAIL
 }
 
+# The jiffies converters report the sign separately from the magnitude, so a
+# negative value must survive the round trip through the converter.  Each
+# value below is chosen to convert exactly at every CONFIG_HZ.
+test_int_jiffies_negative()
+{
+	local t="${SYSCTL}/int_jiffies"
+	local m="${SYSCTL}/int_ms_jiffies"
+	local u="${SYSCTL}/int_userhz_jiffies"
+
+	[[ -f "$t" && -f "$m" && -f "$u" ]] || { RET=$KSFT_SKIP; return; }
+
+	printf '%s' "-1" > "$t"
+	assert_content "$t" "-1" || RET=$KSFT_FAIL
+	printf '%s' "-1000" > "$m"
+	assert_content "$m" "-1000" || RET=$KSFT_FAIL
+	printf '%s' "-100" > "$u"
+	assert_content "$u" "-100" || RET=$KSFT_FAIL
+
+	# The positive path was never broken; keep it covered.
+	printf '%s' "1" > "$t"
+	assert_content "$t" "1" || RET=$KSFT_FAIL
+}
+
 test_uint_plain()
 {
 	local t="${SYSCTL}/uint_0001"
-- 
2.43.0

