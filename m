Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795141645;
	b=1u62gKaSA6APi3SgVPj1B/FPeHOY945SYU7Ksdl7W2/ALL3rpGqaDNHTHpIXuolBy/W6
	 04EoYHnZQs2iFByXaITcanTj0jtnTk2pj4+cahAMVVCHD/s/LECrhXnmN5+7mdMfv9U0T
	 vqH05yDNXyW8DOTF1CNp97iu6LrHgU7FB3kw5hb0HocaPrdzoGOgd/diY8xyqiE6QWPoh
	 KYLXoNy15cs2mSjdJ/JA0Y+noRuJYUL/JHostThgfsH5EOOeL2HvHhU5XVkRlmj+dYCBr
	 yA7NZmm++3xru9DI2LKC2Ncb0k4GyfTIzglU9kxpgKQI06aMdCV2LDpq3UkNawXgnWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795141645;
	h=DMARC-Filter:X-UUID:X-CID-P-RULE:X-CID-O-INFO:X-CID-META:X-CID-BVR:
	 X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zeP4qRxfMev4qDyWHvEpiBpmuLkuazmc6KC3D7OM+n8=;
	b=oDUWl0I4o0YZa//Vm7NBmHvbhFFxEE9HjlSokSe1XUHVdBiQwmI+iV0a63iRyGVCOkN8
	 nkGAM2UccCtDWA0q9UobyIzSHJAYxcrn1MCiwFc2lSwCLbNc24uIHQgzFn0I8j5MlosE9
	 5tTWORejl6ASMSFs956AiDpiYge/x2Kiw0KlpJbQEF+NudTDwciaVjwLAxl+vRfwjXola
	 9Ukr915CLSceioJQNjubWzQEpflhe1ZsdGzbHyR5I8fA1gs5UHi27eId9u9jB5ANzviDV
	 VDIByXe6Y/xElHsukIaPJIKdf24s94XECsj2XcA7R+jEc410uinZF/y8HnmxqIX5Ytg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF193606A320;
	Fri, 20 Nov 2026 02:27:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF193606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: e7562ec8e48911f19a56ed5b684f684d-20261120
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:ae224689-2f29-421c-af83-524793095fb6,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:d5cd3cb6a47cd4c19750056d46bd2cad,BulkI
	D:nil,BulkQuantity:0,SF:102|850|865|898,TC:nil,Content:0|15|50|99,EDM:-3,I
	P:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
	,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e7562ec8e48911f19a56ed5b684f684d-20261120
X-User: fuqingshuang@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <fuqingshuang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 724502791; Fri, 20 Nov 2026 10:27:16 +0800
From: Qingshuang Fu <fuqingshuang@kylinos.cn>
To: Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>,
	Shuah Khan <shuah@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	"Liam R . Howlett" <liam@infradead.org>,
	Karl Mehltretter <kmehltretter@gmail.com>,
	Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Qingshuang Fu <fuqingshuang@kylinos.cn>
Subject: [PATCH] selftests/proc: include linux/mman.h for MREMAP_DONTUNMAP
Date: Fri, 20 Nov 2026 10:27:10 +0800
Message-Id: <20261120022710.1585112-1-fuqingshuang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
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

glibc versions before 2.32 do not define MREMAP_DONTUNMAP in
<sys/mman.h>, so proc-maps-race fails to build against them (e.g.
glibc 2.31):

  $ make -C tools/testing/selftests TARGETS=proc
  ...
  proc-maps-race.c:691:58: error: 'MREMAP_DONTUNMAP' undeclared
    (first use in this function)

Include <linux/mman.h> to get the flag from the kernel UAPI headers
instead of depending on the libc version.  The proc Makefile already
adds those headers to the include path via $(TOOLS_INCLUDES).

Fixes: 6a45336b9b6f ("selftests/proc: extend /proc/pid/maps tearing test to include vma remapping")
Signed-off-by: Qingshuang Fu <fuqingshuang@kylinos.cn>
---
 tools/testing/selftests/proc/proc-maps-race.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/proc/proc-maps-race.c b/tools/testing/selftests/proc/proc-maps-race.c
index bf4c5073f6fc..7d2d9144fedf 100644
--- a/tools/testing/selftests/proc/proc-maps-race.c
+++ b/tools/testing/selftests/proc/proc-maps-race.c
@@ -33,6 +33,7 @@
 #include <string.h>
 #include <unistd.h>
 #include <linux/fs.h>
+#include <linux/mman.h>
 #include <sys/ioctl.h>
 #include <sys/mman.h>
 #include <sys/stat.h>

base-commit: 20eef29b7c8465ac98d7dd6d6f2ac07a8d8056ca
-- 
2.25.1

