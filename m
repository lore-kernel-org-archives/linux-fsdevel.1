Received: from forward101a.mail.yandex.net (forward101a.mail.yandex.net [178.154.239.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063C133B6D6
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Aug 2026 04:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786680773; cv=none; b=MpdrUb6FoRMQ5Xfz3B0gik27ni0AZ8P2KHiE0N6PjOnwqsR0okEbSeOxJQahp6P/tqRD7fu53fd1U0HZqJ0m/47tFhDCqV5ahjvkcZBysgIhYR/lb4vRb7FBz9OOm2Qoy1/7rveZcd1l3XYPROiCCZXwveOhhMvep4qC1v1Qw9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786680773; c=relaxed/simple;
	bh=puI15+BKqXecXkcATaWsXU2O7FGuXAloXNoz3AV7waU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IJoK+sbrLH7SlcL7j5sONzVbYnOP2BktABpSVrFa0LrDm75cfuoVR/MwVN5qukyHmRNjujwKc+IVhnh8N5lz8IrTxtfBRSgnl0fX81i9jWaixD90pvTItvxw3Fh/7sl1gljdUlXP35vMD4wGUCLgevPn5EQdzTOhHnw5dzNa20A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=D+kDf2gO; arc=none smtp.client-ip=178.154.239.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="D+kDf2gO"
Received: from mail-nwsmtp-smtp-production-main-85.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-85.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:1b8e:0:640:314d:0])
	by forward101a.mail.yandex.net (postfix) with ESMTPS id D3B438065E;
	Fri, 14 Aug 2026 07:12:41 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-85.iva.yp-c.yandex.net (smtp) with ESMTPSA id eCIBWrTfH4Y0-0f3cjk2M;
	Fri, 14 Aug 2026 07:12:41 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1786680761; bh=m8F0jZ3x2lHPH9VZfgXqSxjCkVLv06gpjNmL/ha0XMk=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=D+kDf2gOXA2JumLQqou9R5H2kCp0nxZJ7CQjr3u3DL9ZCq+j0y4xxeCYGvxd0ldsA
	 uxdfnaydlLWf2yEOTkqbYdWDNW5I5cjNYsnBowu1vKLEEjbHDkDjpplfA0IAo8THpw
	 rXSTbL+nyZ1h5qE9XUjSCgc1IWQeTCsGZw7/71tg=
Authentication-Results: mail-nwsmtp-smtp-production-main-85.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] ntfs: simplify ntfs_reparse_set_native_symlink()
Date: Fri, 14 Aug 2026 07:12:13 +0300
Message-ID: <20260814041213.1216698-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Avoid redundant 'strlen()' and use the convenient 'strreplace()'
to simplify 'ntfs_reparse_set_native_symlink()'.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 fs/ntfs/reparse.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/fs/ntfs/reparse.c b/fs/ntfs/reparse.c
index fa523dc3691e..1298cfc3a707 100644
--- a/fs/ntfs/reparse.c
+++ b/fs/ntfs/reparse.c
@@ -894,13 +894,7 @@ int ntfs_reparse_set_native_symlink(struct ntfs_inode *ni,
 
 	err = ntfs_set_ntfs_reparse_data(ni, (char *)reparse, total_reparse_len);
 	if (!err) {
-		int len = strlen(sub_name);
-
-		for (i = 0; i < len; i++) {
-			if (sub_name[i] == '\\')
-				sub_name[i] = '/';
-		}
-		ni->target = sub_name;
+		ni->target = strreplace(sub_name, '\\', '/');
 		sub_name = NULL;
 		if (prt_sub_shared)
 			prt_name = NULL;
-- 
2.55.0

