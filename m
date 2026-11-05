Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793890703;
	b=qI3bRjoP+dM/VgAmdMbajlXOyL2cG+uZmfZ7Kl/0aO+9qvcPSGXOnGLMglSiw4qTTkQM
	 /R5JBCfsBAIx+1UJGiHs5ZqWsN1beJyQ2aMqP/t5N6tpcdL78Xgyne0g8eqr+QNRO5UtE
	 FC1QFexO80AQIki8OWMR5hDSXEbXC5y2piB1aRJ9ADuDWPGJDDzHE+BJlG3Qa8QZO+Krx
	 4ypC6tzUYffk7Ta1gmzYFh4dGmFOStJT3gdavV1MOOdlyjAx5bbqSd8tqYeMfeMoW4rBh
	 PXaBfXhC5sni2xhhW/9Wp+JKbLKfH2djjE28n+9cCctk67jFqLo8sHC+6N2ABQ64ogA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793890703;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=H1stpwrLZ6auV0mYKkOepVEMvJtvARQMcHoHV4Y2RjU=;
	b=wDqGaDjc2XZ31xrY4TKUZeRbqf6LQfRX3VLA6UxSxz5dU9JvxeGBmhartdPVD9HvEOUV
	 sTIAlpbwVhUd7LyupEcnUkmpjLa6JEqEOaXmgL5zV/XQIZVjFdSM1q24dzob50heLu+OR
	 0cijP7o6ubKTvXnWyoHBCxf6f8BQjENmvfu0DlyvKbUaPKx3v5JB8AZw17JJMthnJ+yjf
	 rXdby9ieVnUXeYAhajqnF9sN1CPn3JUW0xQOR0G5clFp4/ewpzNx3bIaSnFv9EstLh0EI
	 fRfFyx2wXDhn0+9CP2f+I+Nub8aPbiC5N/tWP/x9X+8e67VOepEV7aeUuBt8N6+2lHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=A++EXYxm;
	arc=none smtp.remote-ip=209.85.161.44
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FEC606EE8F
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 14:58:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86FEC606EE8F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=A++EXYxm
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-702fd86d674so1295764eaf.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 06:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793890702; x=1794495502; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H1stpwrLZ6auV0mYKkOepVEMvJtvARQMcHoHV4Y2RjU=;
        b=A++EXYxmekBv2s8nG6S8FSKUj2jWd4PGNDrKKJJF0hvCDnLmNvR9Uu8BnMuQIh84i7
         DAq8iOY1yUj+C/gFg4O6NoG+D8r6gHDzQGgX3Bbyakhi+Of1gUBgOsVXl4vnLZFbAl+o
         2xNZwgqTOnUfDqE4V/3UrT4Op72siPHvCpnqb+q5AToC0rpj2d1Xh7j4dbduE4nDi9RK
         J6yB92p0k/vw+UMzbsDaNyoL5gVxAVECIHfTqf5WQoX8jNRz2CN0knErduIJ0uAdS1ii
         aULqrIfeX2wHs4/H/qH/Qfk9TN/WGBwd5R+NW0yugeP44fvzGQLViP9fwLITtebp7YXY
         tcQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793890702; x=1794495502;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H1stpwrLZ6auV0mYKkOepVEMvJtvARQMcHoHV4Y2RjU=;
        b=t0Qmt8B5BsIgMKWCVYIdsL9e0b9N2ta+q4+M+2yYBxFQ5ItBapQ6GDmtReEUYNEZdy
         q5b21wFlyRGK2WAcfU2q5S/XChNK7QNUB5KvU7iMsDoKfOS6TOG2WcNHnQN/n0cO36DO
         9w4auasOrIZl5xo4uDMnh8DJJwlP8988sDPx+ZzEntscIou+jy1jtiwdkpqp8oz2DiUG
         Dq3qt/FCckX/5vaAyUXHO9TLWwxoEBMrxo6lGL2USInE+jPRsnb4joFljp+9hOProSMB
         bEh02PaVQWCTVfOfbryUrADIn4Qa+ZoLEWCXbvFDlBaOR5Wb6YXz9Z/J/lHaxKbi6i+y
         FGGA==
X-Gm-Message-State: APuU4Z/eASoBus/AzOCjzeGXPYrqU/jVluM67qwPhuDtbnwRPxJMmaeE
	f4EkJlQVK9b13lhwEcDq4yaRo0bFza1FpXj5fXkv0g6JyzgmpGwKedRcznXR/7PdQEs=
X-Gm-Gg: AYBFou2utHbMxKRBu3pP0draVjrhxreCHr7cVqWEzk2fATO7XW+C+5gHeg3OGQ4KAtN
	jEGvPr8Q8E42Bna0ETDFoQlvrxVRc0j/xhIz3zMvJT8lNwDyac1Tk3eiSdqUuX/dCmM6NUJzDup
	nxr5Il0atAANtm57tGEPT3IYguSj4BXNkt5/CWX2VTHiFhIYt0TQ0I3EbnUfNE98pMKDqj9J2UG
	2ZefveZdD9Ll7/jTElw7lrwnrGIiglh1PPvxU8UYjKy6ZtpIA4SKjmSO+v6eWz83mNzCR5+1X3L
	1IW/62g3/NLxM9PheL/nI0nZbZi+3FJelkTp+6eWf45mS9yv2Iz88+BmVLWKiF8NcY0kofEqe/U
	Ffy3n7aP0GfMhvktZddi59anEVxxVtEz7LAhqVsr+EHIbDKDUW8SN0gUAMWwFIBvMvv57rjtvQv
	qRAwHFxBxvBCOYTgGBzFvRm8LIicTFfkZcqyCnqbTQIzfaoZ3I5IQqYh7qSLaa34FL6ICU9qFtf
	t0PV/Spfv+xAqXq3riOj/RpRHENkG4oWhK9V4cxMmk/PzsbW7PbofpvYvIIdbyX3dDg1lV68Up9
	VXeSU4OifOJaRUUmSTdsX37vpwLiJMySEv1o9Pwfrfu0og==
X-Received: by 2002:a05:6820:f029:b0:70d:dc1f:8883 with SMTP id 006d021491bc7-714f23f5e03mr12130997eaf.35.1793890702346;
        Thu, 05 Nov 2026 06:58:22 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.250])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4acea547bfasm5003452fac.7.2026.11.05.06.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 06:58:21 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 05 Nov 2026 14:57:05 +0000
Subject: [PATCH RFC v3 14/90] fs: take no id of a cell for a mount option
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-b4-cells-v3-14-bc9095937a84@toxicpanda.com>
References: <20261105-b4-cells-v3-0-bc9095937a84@toxicpanda.com>
In-Reply-To: <20261105-b4-cells-v3-0-bc9095937a84@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>, 
 James Bottomley <James.Bottomley@HansenPartnership.com>, 
 Andrew Halaney <andrew@amutable.com>, Jeremy Bingham <jbingham@gmail.com>, 
 Tahera Fahimi <taherafahimi@linux.microsoft.com>, 
 Serge Hallyn <sergeh@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793890670; l=2208;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=Vn2rnoSO++eAK8WFIcQeXvGMeknHoBHY25i81qye0GU=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QFZU7x+FLD8VfyykqJXBl+60IQfKGF2wHRw5Bhaj+uynYzCC42zXiSo/m9/qrS06/DP28WPShdM
 rFkD8YsqNGQM=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

Most filesystems with a uid= or gid= mount option assign that id to some
or all of their files, without checking whether they may hold it. For an
id of the window this has the same effect as a chown to it: the files
would belong to whichever cell is lent the block next.

Only root in the initial user namespace can name such an id, because no
other user namespace maps it. But the rule is about the value of the id,
not about the caller. Nobody is supposed to name the ids of a cell, not
even its builder.

Refuse ids of the window in fs_param_is_uid() and fs_param_is_gid(). About
two dozen filesystems parse their options with these.

Not covered are filesystems that parse the number themselves, such as udf,
ntfs, zonefs, functionfs, hypfs and spufs, the access= option of 9p, and
the anonymous ids of an nfsd export. The design document lists them.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fs_parser.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/fs_parser.c b/fs/fs_parser.c
index b4cc4cce518a..0e8c84459c45 100644
--- a/fs/fs_parser.c
+++ b/fs/fs_parser.c
@@ -5,6 +5,7 @@
  * Written by David Howells (dhowells@redhat.com)
  */
 
+#include <linux/cell_ids.h>
 #include <linux/export.h>
 #include <linux/fs_context.h>
 #include <linux/fs_parser.h>
@@ -331,6 +332,9 @@ int fs_param_is_uid(struct p_log *log, const struct fs_parameter_spec *p,
 	uid = make_kuid(current_user_ns(), result->uint_32);
 	if (!uid_valid(uid))
 		return inval_plog(log, "Invalid uid '%s'", param->string);
+	/* Nobody names an id that is lent to a cell, see kuid_storable(). */
+	if (cell_id_in_window(__kuid_val(uid)))
+		return inval_plog(log, "Invalid uid '%s'", param->string);
 
 	result->uid = uid;
 	return 0;
@@ -348,6 +352,9 @@ int fs_param_is_gid(struct p_log *log, const struct fs_parameter_spec *p,
 	gid = make_kgid(current_user_ns(), result->uint_32);
 	if (!gid_valid(gid))
 		return inval_plog(log, "Invalid gid '%s'", param->string);
+	/* See fs_param_is_uid(). */
+	if (cell_id_in_window(__kgid_val(gid)))
+		return inval_plog(log, "Invalid gid '%s'", param->string);
 
 	result->gid = gid;
 	return 0;

-- 
2.55.0

