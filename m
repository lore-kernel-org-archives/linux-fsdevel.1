Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792787989;
	b=vjUMZOF8ITs5PsdixO/cmvfYvMreBTtOyZBmxets+prFRdUkTxYLlrXL88unBbyF2jjp
	 3DaJwUKynYKQN9cgUxl7Dq5T53l9MF1FSPp1vsbUD1RFVuaxBxqvw/99iOun0Gk15tg1A
	 NzuBsuk8IBFbmVS7WYuRM+uF1dG6kK1DR8l25emi0Co1QJe+ekbOI8+vmWs9mwhZSOk2d
	 88PZZDJUCDwkRV9XxSrVskhYq2GQ62DOHnDIpiTDWrmhZnKhh69W2WFjFo5U2Yw0W8NNE
	 yDyuEQDHj/pENRG98az3rO/EsFlDMRx570TGp6gs7GnNGiNDQRKML3HO4vE2O+9mkpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792787989;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=joBq8zZQZw7xm5XS5EnT5tSj+OH2u98OsmcyfjTP7BI=;
	b=eN7I2/ElU1IX958+PrlacHxSFh6kspkz8S/sLdM6Qk3MJnvBGracDbhJbTLyoPkIWfXo
	 hjCEhY4SAiONLLn0ecFBZb06SVR7+Yk8rTL07Y/IzmMsZgOMlVW0yTuQwa72bOnsEtmDB
	 y0RuXQixdSE6+Th7CrnhlWEdUiVPEVFixf9mf18Z6ByYSQw+SDm3csEcRAPo8rgjzlBV/
	 Bc9zsIkSfScFB9KSSC6BP06Tdtgzj8VQ5khv90UAQ0Z9mKCQp0TohsEZl2Hw3RYyKfuz7
	 LZGse0rBY4bvaDz6UPOdfoArcXCmhrju39DeeIbqBgn5p1K5pLWP7X3h19FtUUPFx8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=rnZUsKJN;
	arc=none smtp.remote-ip=209.85.219.51
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1441D606A31E
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Oct 2026 20:39:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1441D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=rnZUsKJN
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-91b8b456dbeso14686346d6.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Oct 2026 13:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792787988; x=1793392788; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=joBq8zZQZw7xm5XS5EnT5tSj+OH2u98OsmcyfjTP7BI=;
        b=rnZUsKJNsKN8ucr/+81v9CEZC7uULbAvGGsKrLc11qT6ZCrbx34Z1SoC2VoYh+uiQh
         9hz1QS3IrsPjhHfOr1Yu/VA9QQd7tyz3CNO3bEfy8FPOwqj99HfNs/Q8jK7vQX+Jhen/
         ekrWV2wxzMKU0CG5XYHqlgiyECDzVCEhzjIfaJddqHaKbgKetQRFiJNvj+/B8/aaJsPA
         ctIRuSa87WyAjXLVHgE2vty+HLxBXuMFaQs3OfOAnCOI6idjhz/OML429QpGxp2/cRqM
         +Cwb/91fgGMYO653ljI6WHCl72mpndmNZNLzkiNmyBuD2OxyNDZzdSrS35mT+4wp/ie3
         Q2qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792787988; x=1793392788;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=joBq8zZQZw7xm5XS5EnT5tSj+OH2u98OsmcyfjTP7BI=;
        b=iGj7WJHIZfO3C58WimY1mt4kIvHTAvPA5eyeWCbm08cu59wn5gcjiFOw+s3IatlxYF
         mZwTjEIaljoy5vbEwnQq0+dC1ecduqwlWlZryvKWF1YyjA9D/A7fG0tL9IbQLoTsPDpA
         9bWbForbhFP1xF/EfU6Dh/TW8ALqtKFRWbL2uRuvuZoV2r+feT/7SH4cfrnEG8L7xBav
         7X5ys9FLR1FTSc2riR8t77jV6HkjbavYA9B3B24wESrM2fac4DvUhHG4elKgJtWtbDYf
         k1CVwQtznzDUNdc8x+BYzWp3oDrpWm+v4Kz0wgcUgPrnAok0ETQ/C16CLuD3s4xiOFiJ
         cwHg==
X-Gm-Message-State: AFq9FYIDtiO8wHZbvQj3dFoepW/OeB8q9M6LwZZZ9ssOA0dGMZqPRCIR
	bH2MpsEFZY0J6z+epFyQc0eJ0+G9Kt8wN/1xPMrqsYsXsem9EnUHZRMcFNoY1vCJam8=
X-Gm-Gg: AYBFou3tfvQpXrWmsxtqsdoJ2bCDuoOx55hkk6m+RltcToTvNrw15MWuyU3v/LBpaDs
	fegCtovZq7OlblklVWPNKSoELypBXd5nmxl5z22j/giS6hsmctf59latFJY8/iosWrtyzrz7jgC
	ZdFCWRazeoINzJEYgEl1ntRCnDm1w8TDPTbcsh2OTLEs8bpXmIgUWI3DjHFRo8GwZew8FSv14Q8
	wbsmoArW7P7Fv0IhBgs1xqRSXb+YDFDe30IcKLq3BWHx7AaKt24GMXmOS80aZvQYwVC5eHoYUuS
	M3qj2Y7q4tJaXDyUxZ87bQj+1wHiqT6ui/lXCJJzmHUc/VdqzgCUkRNCLWfx1PCRsrB25GuS1QY
	suWoLd8ku6pVrR2oqww1G5kpUNzz8y0fQJgwFyW3yb38zaGtYS5J4LrsmGKlixzfj4Jn6HQPoJT
	OdzPzeSbdUHO8QlVOFtz5ggYgQ6KtJTJfiUGVrO3n44blW+Q2phnS57lImcjsk198b6mBmbJ0ta
	hFRDu3CnUtEY+8lZ0HXItczlSBXgwMHymzjtjYCTRS7zaRXyaZprfmAUtRBb6SAIsfqo1qa
X-Received: by 2002:a05:620a:2b82:b0:93f:5f83:2ca4 with SMTP id af79cd13be357-940ef97bd9cmr26198285a.51.1792787988058;
        Fri, 23 Oct 2026 13:39:48 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.242])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940f068328dsm3074785a.23.2026.10.23.13.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 13:39:47 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Fri, 23 Oct 2026 20:39:32 +0000
Subject: [PATCH 3/5] fs: make mount(2) remounts killable on s_umount
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
Message-Id: <20261023-b4-s-umount-killable-v1-3-844a341ff1df@toxicpanda.com>
References: <20261023-b4-s-umount-killable-v1-0-844a341ff1df@toxicpanda.com>
In-Reply-To: <20261023-b4-s-umount-killable-v1-0-844a341ff1df@toxicpanda.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Jan Kara <jack@suse.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1792787980; l=1659;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=21ycwsFWqOYt//g+Upk3NygtveQIX34cXPdaquwsbgE=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QLi90bNtWIHcr4hcJzZXDJpXYEl9y0XtUaowC+Y7MMp6NDdPpa4E/8ne+HjjJfs4J6MAM6uXHhw
 9fa17oKSsqw8=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

mount(2) with MS_REMOUNT takes s_umount exclusively, with MS_BIND as well
it takes it shared.  If the lock is held for a long time, by a syncfs(2) on
a device which doesn't answer say, the remount sits in D state and can't be
killed.

The one which wants the lock exclusively makes matters worse for everybody
else: while it is queued, every new reader of s_umount queues up behind it.
Killing it gets it out of the way, the rwsem wakes those behind a waiter
which gives up.

Nothing has been changed yet when the lock is taken, and both can fail.
Use the killable variants.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/namespace.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index e5feb4e48290..837f531e494b 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3485,7 +3485,9 @@ static int do_reconfigure_mnt(const struct path *path, unsigned int mnt_flags)
 	 * We're only checking whether the superblock is read-only not
 	 * changing it, so only take down_read(&sb->s_umount).
 	 */
-	down_read(&sb->s_umount);
+	ret = down_read_killable(&sb->s_umount);
+	if (ret)
+		return ret;
 	lock_mount_hash();
 	ret = change_mount_ro_state(mnt, mnt_flags);
 	if (ret == 0)
@@ -3531,8 +3533,9 @@ static int do_remount(const struct path *path, int sb_flags,
 	fc->oldapi = true;
 
 	err = parse_monolithic_mount_data(fc, data);
+	if (!err)
+		err = down_write_killable(&sb->s_umount);
 	if (!err) {
-		down_write(&sb->s_umount);
 		err = -EPERM;
 		if (ns_capable(sb->s_user_ns, CAP_SYS_ADMIN)) {
 			err = reconfigure_super(fc);

-- 
2.55.0

