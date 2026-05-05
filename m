Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783363BE17E
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 May 2026 05:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777960442; cv=none; b=p451RcemAZ4iv+q4JKfL04T8DHqRL/xKbM9MfUK9WhcSdkWYovTQg1+8tNCuQTa1WoLwCHgLhZJv/tSAt/yEdseS7GQML0unV7zoJfdAb+2uwjMs//VpOzEhPzmsQGgziUpcxo7zDtrNxx8lvNXCjCmUFCrI5vHa2V/8rGZWrHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777960442; c=relaxed/simple;
	bh=XesKTswlqpsK44/nGgesDLTtU1/jlBUp3ekSF+ui4xs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tta5goHxKllEiKcl0Cc40SQgxZNaWK/QmU5eMC71BTaN0WldE7EV2RK5/7zLt74Xi9IAak/NV/KLaavVJ9L4jSRCHfZryX+wL4dTJRoKuqrZuIs9z5pSGdb5ejUOS9Nn8TCJ/j7dt5S3jQjHJ/oNCQ5VSWGn2/MuKr9rXSdwewg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=OofIvLIG; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="OofIvLIG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=EatBGXg2aRIJM5P8T+5tvk4ow6zSFcpe2JIn9/ZaleE=; b=OofIvLIGFnCtKoFMH1yJ+gtPQN
	Z8On2QfySKFKPUpxFu4QPz5i16lgGqGWi3LgquL/taCEP9g9XOukORkZaXj0uWqN5c1xUMdozVzqU
	PiyIT/+4ViKwuPuVYucknua+XNG1MVK5O+B1XX6PgY59fUa+plR+wWFXUvTjAjIoz91Zgl0O7vtp6
	8QyPcHgrcewqBJejMbCTSWG0rloWPl0uvbQekPm9PES6syEkKlQ5EpnGZSQbc4lFipM6B0MxyarW7
	91Fc1rFkfaBJT34TJETGAYqESlUhDFXNS3kzhB7eeWEQPrh/QJDO/rE2M/Kk/+am0sgP6LacuOkqf
	QbAdZ11A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wK8jX-00000005I5f-0Yjz;
	Tue, 05 May 2026 05:54:15 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>
Subject: [RFC PATCH 05/25] select_collect(): ignore dentries on shrink lists if they have positive refcounts
Date: Tue,  5 May 2026 06:53:52 +0100
Message-ID: <20260505055412.1261144-6-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260505055412.1261144-1-viro@zeniv.linux.org.uk>
References: <20260505055412.1261144-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

If all dentries we find have positive refcounts and some happen
to be on shrink lists, there's no point trying to steal them in the
select_collect2() phase - we won't be able to evict any of them.  Busy on
shrink lists is still busy...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 923e499ffe7e..f3e909c7aaad 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1589,9 +1589,7 @@ static enum d_walk_ret select_collect(void *_data, struct dentry *dentry)
 	if (data->start == dentry)
 		goto out;
 
-	if (dentry->d_flags & DCACHE_SHRINK_LIST) {
-		data->found++;
-	} else if (!dentry->d_lockref.count) {
+	if (!dentry->d_lockref.count) {
 		to_shrink_list(dentry, &data->dispose);
 		data->found++;
 	} else if (dentry->d_lockref.count < 0) {
-- 
2.47.3

