Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8224CCDC0
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 14:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790174989; cv=none; b=jry9Z9xw2FsyDy3vec/PpPbfF2v40kqcKVQ+SRDu0pWVhmxxVmyjCuUKhWzNrL5rHftNqvXMidlcJASFYVAdQgvUkI+RkZXHsPESj1lkR7frR/1HWOnRKpvLimFiBUIjdaqpkBH+HH1FX0WguIGY62LUsRQNtZudTEifIn+a0sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790174989; c=relaxed/simple;
	bh=gfEequ5h4M8nOx752p9+V+yKr/bMfkzst5fdeEdSG6w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cpvsVeXgo4xi/n7l9LuZq+9SgzEoDhQhDRJO9IVD6SzKGnqEC0AWPmtVmaWXCjbxpAu6L+SV31T2EHh5GPT4MbzuDqS02oG5wLpAeYf4mZKpOj/pVv0G5inn0kjtUxF7eVpE1bZwAG3YKPU/RxhEP1phIGgDAC7xxtSeDu8CCKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P+LodU5s; arc=none smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+LodU5s"
Received: by mail-pj2-f42.google.com with SMTP id 98e67ed59e1d1-3a02902dce2so603897a91.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 07:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790174987; x=1790779787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6r6fXqXYQF9f9eR7w46g/DoztkMVGuog+jM74AKklwU=;
        b=P+LodU5sZYtkT2sRUolAS58SIGPfMnazoXkm2Fh4pm8OjlgZwSE7QIb8rIAdq2OTUa
         ixkLstqjXy9NmLEr8PosoTuhPOn4Y6iVGUxu4e8qLyW6eHaCgfkLKC552tC67yb7z0jo
         pQbQIDyuBCFWxff9h7F73No3NjHaR1Oh2b5etBxrFYD53TX+a/Cj4I4Dy8URsJxqfxFp
         nWiTeGfi4XFOIgpBZucNQhcY99immHuD4W+0UMvfUtkXrUcpWZ3hgE64flaMst5LGgZn
         u1YKE/FBXKwtKIpxugUGYAN5uLEJ+FKl7coGQxl2ugFTd4JlQPS7QQ1jOUA+qVoZoSy7
         dd4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790174987; x=1790779787;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6r6fXqXYQF9f9eR7w46g/DoztkMVGuog+jM74AKklwU=;
        b=EWq+FRcNvBBCeja3GIVPYVchrpzPyQupka+lGFuBP6jJUG1vHvMNP3CT8gk4VunwIZ
         uaq+lQxnFTNjwkrVng3YA4VbqXu6LIXGmE4yA9HoslX3aqWd/LQ+WYRS4ejg8IaBYD/i
         mYV82/9k1Cbw5zX4aehZN/oSijVfCePC0tiPnvWUQdUG5Uiw9Sr1STDMcMhWfeYNdvkh
         WKGvYOKPpqL0hBUi5f1bctLJ92uJprmzJ475qXOa6s/eETX4F8xX8mmOpjrWpK0z5PNC
         YmP3+HNu8OfjaAlvQjCb5jd2BcLn4gn7U3K2ssGKoMB4a7qX2/ZC3/lNw2H6TfN5G2Mt
         Ri2w==
X-Forwarded-Encrypted: i=1; AKwUvBw7Uw4arC/o4pa3mQoQ9bXV+mxVCsn08e2FfTgP4iWYTPyPUP2CxhPwd/V+EuUwoK+gqWzq46zeCJ8WXX5y@vger.kernel.org
X-Gm-Message-State: AFuF++nxVxsNT7vH2JwQ7yPO7MrgURXmPo0h9Mk2v7kDY5VOTDcckCqO
	Rup2gxdYanmuP+3LITlXM/HcLTYE73UX4ub0C9U1LbH7I7D+q9FglMkF
X-Gm-Gg: AYBFou0F9ymN5gevuYB/9c2dHNpSmhcs6xlXMU7cT9cptfE9WFrwxnZLsTRVXsm+b/P
	9Alla7rHM8N4z2Weaqqbnzbg89troRrHLR+TrdpQP/fVqUpbDEn9mBRLC2NC5thosEVKhggAPwS
	wlhtvYyNvAZgRmpni2w8SrBdWfWs7I90bOH+drPQQAtExzyaISN4VAtRxLK8SVLa9sb77e90xRb
	4gk6Q1Z3iQxz9tAUZp2B5QH+cESyCcz1/ouaA49bmIDEjHe7kKDOTJ+cNx12xu0X6xMy/u8qnJC
	IFWZiCvPoTkKaQlctHRCebx6bm/OWfnNlTaUFtve8z9QLT869lpVwwI0vwRtQKuk1wQ0zUrfYAs
	Pv0skz5+ZD7Q1HgmYoa73wjaPX49P6hbjV8oY5pLVAB0hhoD8Py4YTQbLcsH9ASg9ykstteRTYY
	cD2bN9uO2jFl+8ST4kcsdNXw+bRLiqrmpz9ZzWG7Yp8zYxC+2ZAzQaevreqyF0TpJpwKeBY03de
	TvHwqJAqGqnx6UTHMLb/w==
X-Received: by 2002:a17:90b:3f0e:b0:39e:59a0:46b5 with SMTP id 98e67ed59e1d1-3a07e5606a5mr2414557a91.24.1790174986717;
        Wed, 23 Sep 2026 07:49:46 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a07dc4109dsm6469824a91.14.2026.09.23.07.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 07:49:46 -0700 (PDT)
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
Subject: [PATCH 0/2] sysctl: Cover the jiffies converters in the selftests
Date: Wed, 23 Sep 2026 22:49:35 +0800
Message-ID: <20260923144940.3712965-1-zhanxusheng@xiaomi.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Joel asked for a test for the negative read path fixed by

	https://lore.kernel.org/r/20260922031229.2300283-2-zhanxusheng@xiaomi.com

These apply on sysctl-next and depend on that fix; without it 2/2 fails,
which is the point.

While writing the test I noticed that fix's changelog is incomplete: it
names proc_dointvec_jiffies() and proc_dointvec_ms_jiffies(), but
proc_dointvec_userhz_jiffies() goes through the same
proc_int_k2u_conv_kop() and is affected too.  Measured on
net/ipv4/neigh/default/retrans_time at CONFIG_HZ=250, unpatched:

  # echo -1 > /proc/sys/net/ipv4/neigh/default/retrans_time
  # cat /proc/sys/net/ipv4/neigh/default/retrans_time
  -18446742229035144246

I will correct that in the respin.

Tested in qemu at CONFIG_HZ=250 with CONFIG_TEST_SYSCTL=y, and built as
=m.  2/2 reports "not ok" without the fix and "ok" with it, and the
pass/fail counts of the other tests are unchanged either way.

Zhan Xusheng (2):
  sysctl: Add jiffies converter entries to the test module
  selftests: sysctl: Check the sign of a negative jiffies read

 lib/test_sysctl.c                        | 31 ++++++++++++++++++++++++
 tools/testing/selftests/sysctl/sysctl.sh | 23 ++++++++++++++++++
 2 files changed, 54 insertions(+)


base-commit: c5c4ca25387e3cefd1af64edf9187546b6d06787
-- 
2.43.0

