Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792544220;
	b=ItaP2tPwj25xmuV1293qMuVYzRDhqwQWE/Vs+XA0rSfy6/cpywyOezdj1GMDbohdTwMW
	 gPmjLkU3KRo8iXLEjGsDmhc/d+8P0TnS8tmh3jmqe/A9DCf9XQHsQ8qLA2fNx67oIR757
	 cA0TgKJxPVp2QH//IH3vW+fa+rrmj2ML7D7edtVIpEVnAr12aIAk91WGtnx4V5Okj1kq1
	 OWMx1EU9r0ATSm7AowM3Khxcfyj1aOrUlGZ67rg1qhn5zdZaEQYbA3XOnAi0vj69xtCG1
	 vaigI+PK7wFCt1BvH4d+jF4naKNBGXOx49IvVCWfmFUqNJGbbMOcpL2gXGboVtn1Tyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792544220;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=DggGTwK6ptrO7pXgD18oDRKEIvdAw4GRiBSpsL7niXA=;
	b=kazIDTyKInpt6N9cd1h8ZSFOqpzmtQvvEJjYfXTzT7gtdrYx/GnDs7SXmH+WgUiCFseC
	 lUHqk30lKAVCookD/MJGwuwZnaPniouKytHMWP6oSuYM2ONMAVES1vdZSjtYz1G+mBHae
	 Hx1kUUYzsx5Ebbme8w+/LfXK1PP92wZc+c6IVsKDNSo7DEqAju7hOYthKsgfZ0tyoBpzw
	 R1Lyl9RXlhPbZreMxDhWT9+azXJlSCXC/lG/up8v1WdsWiDJuuPUMgAXtAiqlBlX3dRC0
	 adI8oCJb5F0G7dANeD1J38nZifp7QTAWFB7FmGhpTMbxwyQdNQaHILRtdCL3wQtu5Gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=jRurbOxk;
	arc=none smtp.remote-ip=209.85.219.46
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1776160A2607
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 00:56:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1776160A2607
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=jRurbOxk
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-91b83459526so2745136d6.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2026 17:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792544219; x=1793149019; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DggGTwK6ptrO7pXgD18oDRKEIvdAw4GRiBSpsL7niXA=;
        b=jRurbOxksuJeZX+G7qAlyLV1dTOAbp6ZZd0UC0fEXf6yu2vt+nkZNF5GFY3t3ZZOW5
         Rzvtu3H/UM+Z2yRzsK7FC8PWSEX77foUsu8fqR1OPT5wITSmYxMJtXJP/zNbCBldY46S
         AYqPJBjCbBVgRYID49ifZOgmPwHp/BW/EJONmEmhVWvGerMKkLqxYjnmvdgobvVMkwOc
         vzX428VyQx6Z16RQpIlmoh8gAHyNOQ3i4F0IDH9g5+3Uv6Xx1Y6xEEGi63/LLcd2zAGV
         /zeoimxFg6wQlq1BwnqggHy2WfQ0FpbIC1Vuke9DGcR8v/ZNDSM6imKXKS/UyAv5eR7W
         GAkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792544219; x=1793149019;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DggGTwK6ptrO7pXgD18oDRKEIvdAw4GRiBSpsL7niXA=;
        b=bFVpZh6VrHBKHHeobJidKD9F4ugEDH3vNfHhzxMQ7Voq+JWvgcFKvFCO4iZt0PKbMd
         LZVDFMzOOO0/xNhsfN1x0MaByHak6X+2UuW3Vz72bOvXlJC5nuEOg3VrRDOlm13wS/OC
         CQ7ZqIFZpuXybxeZiF6mxTB1Q/WyukGOlH/g7aIGkTzHFLViQM+0xEWGmVauSHNuly/j
         emMNv0DU7Q2O6EAZOJ1ElzyMYJQRSeaPpBepdTb/rsuyjzjaPAECkvmOoyhSg6Uz5Ape
         FiCR8lCv/QhhR+t2o+WiKD/3ykayNcxfN9oqcYoisG5fjsuLeInngPjwPwD2UFt09kZu
         FemA==
X-Gm-Message-State: AFq9FYI4Dif05bbo/MT0F/hqFnGQrR8xekU0ks8pGgo0moXhAlCRW6Wk
	DMNNi405r56GbabnaIIkZOnKtiLI85gVimTZaL2MGDc6WbU0sK8Sk+5Az2X6QIoPPgk=
X-Gm-Gg: AYBFou3Qy/P0F8I2N9K/iL8gUgZL72otOEfMbbT7OXpjgTydJagaxFPVbIosAOMyZtb
	xQ/rtoTaqzwapXqVa1iILQ8AJ6dHTxl8Yk0b8WZa+LTRNlaIAMs1BTyKrBY6L4TKXWPLc+WoSyD
	JENWvrvwonJn7z2Pd+fZuEt4uMf9W8Nypj3N6m7EOBVims0r+jOVR/Z6JQQgQjYoo1j8clAMo34
	15vfyhSlZCI6lLb/eiUrC49Vl70Gx1bw9TGbXOGDfwEmeiQ04hm4fNfG3A+dNt1sSKlj0SSKfHb
	P3FpQYw9fczmtVJpXb2V1VZX07EGXCaglz9LH2fPEiZpAbxwxiQHQCOdpwpMN2kpzaeJ/TC8GIc
	JJiac+Y+7KnsWlZ/rhFCyVfGD0CsK6MjujZ45qsFLrbN1xRBsZIvGdlvi+2UABsZW1ffUw0qUxU
	SfKyT9rZbnU5QyI5BHZYSAbPETEtYrClj71Ng/MP1xUp1yH9hirzdTe+yStwJ/PTZ3hV4uvQYpX
	8bKjXDcEPw3d4M=
X-Received: by 2002:a05:620a:4589:b0:93f:2610:fb77 with SMTP id af79cd13be357-93f57f9720cmr186574185a.45.1792544219052;
        Tue, 20 Oct 2026 17:56:59 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.244])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f56c701f2sm123333385a.2.2026.10.20.17.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 17:56:58 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 21 Oct 2026 00:56:36 +0000
Subject: [PATCH 2/5] fs: make freezing for suspend wait for superblocks
 being shut down
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
Message-Id: <20261021-b4-super-lock-dying-v1-2-2b35e86706ff@toxicpanda.com>
References: <20261021-b4-super-lock-dying-v1-0-2b35e86706ff@toxicpanda.com>
In-Reply-To: <20261021-b4-super-lock-dying-v1-0-2b35e86706ff@toxicpanda.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1792544204; l=2609;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=PqiH7RhM0thrZUjh1uOe97M8bg/0B/ggQ2Kx8CtO5Gg=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QLZsCSkiwPZZNL1gvRV1bFRoSfXrVUxBAn1MzjbwfVl7l9eVuEkISszzW16ibAX3NxYqSvSnU1d
 zj98di9GlUA4=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

filesystems_freeze() freezes the filesystems ahead of suspend and
hibernation, so that none of them changes on disk behind the back of the
memory image.  A superblock which is being unmounted can't be frozen, but
get_active_super() sleeps on s_umount until generic_shutdown_super() is
done with it, so it has stopped writing by the time the walk moves on.

That matters.  The freezer doesn't take care of it: the final mntput() of
a kernel thread is handed to delayed_mntput_work, and the workqueue it
runs on is not freezable.  Were the walk to skip the superblock, the
hibernation image could be taken in the middle of that unmount, which then
carries on after the image is written, and again from the middle after
resume.

Wait for SB_DYING explicitly, ahead of super_lock() not sleeping on such a
superblock any more.  Suspend goes ahead whether this task is killed or
not, so this gets a wait of its own, super_wait_shutdown(), which can't be
killed, as it can't be today.

For now SB_DYING is always set by the time super_lock() fails, so nothing
changes yet.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/super.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/fs/super.c b/fs/super.c
index c33981d3f7c0..76101307da01 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -157,6 +157,20 @@ static int super_wait_shutdown_killable(struct super_block *sb)
 	return wait_var_event_killable(&sb->s_flags, super_flags(sb, SB_DYING));
 }
 
+/**
+ * super_wait_shutdown - wait for a superblock being shut down
+ * @sb: superblock super_lock() failed on
+ *
+ * For callers of which the rest happens whether they are killed or not, and
+ * must not happen while the filesystem is still being written out.
+ *
+ * The caller must have acquired a temporary reference on @sb->s_passive.
+ */
+static void super_wait_shutdown(struct super_block *sb)
+{
+	wait_var_event(&sb->s_flags, super_flags(sb, SB_DYING));
+}
+
 /* wait and try to acquire read-side of @sb->s_umount */
 static inline bool super_lock_shared(struct super_block *sb)
 {
@@ -1294,8 +1308,11 @@ static void filesystems_freeze_callback(struct super_block *sb, void *freeze_all
 	if (!freeze_all_ptr && !(sb->s_type->fs_flags & FS_POWER_FREEZE))
 		return;
 
-	if (!get_active_super(sb))
+	if (!get_active_super(sb)) {
+		/* an unmount from a workqueue isn't stopped by the freezer */
+		super_wait_shutdown(sb);
 		return;
+	}
 
 	if (sb->s_op->freeze_super)
 		sb->s_op->freeze_super(sb, FREEZE_EXCL | FREEZE_HOLDER_KERNEL,

-- 
2.55.0

